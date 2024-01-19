
module "bucket" {
  source  = "app.terraform.io/ryanf/bucket/s3"
  version = "1.0.8"
  # insert required variables here
  
  for_each = local.buckets

  bucket_name = each.key
  environment = each.value.environment
  bucket_tag_name = each.value.bucket_tag_name
}

resource "aws_s3_bucket_policy" "bucketcf" {
  bucket = "cfhost123"
  policy = data.aws_iam_policy_document.bucketcf.json
  depends_on = [ aws_cloudfront_distribution.distribution ]
}

resource "aws_s3_bucket_policy" "bucketlog" {
  bucket = "cflogger123"
  policy = data.aws_iam_policy_document.logger.json
  depends_on = [ aws_cloudfront_distribution.distribution ]
}

locals {
  s3_origin_id = "cfhost123"
  buckets = {
      "cfhost123" = {
        environment = "cfhost123"
        s3_force_destroy = true
        bucket_tag_name = "cfhost"
      },
      "cflogger123" = {
        environment = "devcf"
        s3_force_destroy = true
        bucket_tag_name = "cflogger123"   
      }
   }
}

resource "aws_s3_bucket_ownership_controls" "acl" {
  bucket =  module.bucket["cflogger123"].s3_bucket_id[0]
  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

resource "aws_s3_bucket_acl" "acl" {
  depends_on = [aws_s3_bucket_ownership_controls.acl]
  bucket = module.bucket["cflogger123"].s3_bucket_id[0]

  access_control_policy {
    grant {
      grantee {
        id = data.aws_canonical_user_id.current.id
        type = "CanonicalUser"
      }
      permission = "FULL_CONTROL"
    }
    owner {
      id = data.aws_canonical_user_id.current.id
    }
  }
}
resource "aws_cloudfront_distribution" "distribution" {
  origin {
    domain_name              = module.bucket["cfhost123"].s3_bucket_domain_name[0]

    origin_access_control_id = aws_cloudfront_origin_access_control.oac.id
    origin_id                = local.s3_origin_id
  }

  enabled             = true
  is_ipv6_enabled     = true
  comment             = "comment"
  default_root_object = var.default_root_object

  logging_config {
    include_cookies = false
    bucket          = module.bucket["cflogger123"].s3_bucket_domain_name[0]

  }

  # aliases = ["mysite.example.com", "yoursite.example.com"]

  default_cache_behavior {
    allowed_methods  = ["DELETE", "GET", "HEAD", "OPTIONS", "PATCH", "POST", "PUT"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = local.s3_origin_id

    forwarded_values {
      query_string = false

      cookies {
        forward = "none"
      }
    }

    min_ttl                = var.min_ttl
    default_ttl            = var.default_ttl
    max_ttl                = var.max_ttl
    compress               = var.compress
    viewer_protocol_policy = var.viewer_protocol_policy
  }


  ordered_cache_behavior {
    path_pattern     = "/content/*"
    allowed_methods  = ["GET", "HEAD", "OPTIONS"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = local.s3_origin_id
  cache_policy_id = aws_cloudfront_cache_policy.cache.id

    min_ttl                = var.min_ttl
    default_ttl            = var.default_ttl
    max_ttl                = var.max_ttl
    compress               = var.compress
    viewer_protocol_policy = var.viewer_protocol_policy
  }

  price_class = var.price_class

  restrictions {
    geo_restriction {
      restriction_type = "whitelist"
      locations        = ["US", "CA", "GB", "DE"]
    }
  }

  tags = {
    Environment = var.environment
  }

  viewer_certificate {
    cloudfront_default_certificate = true
  }
}

resource "aws_cloudfront_origin_access_control" "oac" {
  name                              =  var.oac_name
  description                       =  "oacdescription"
  origin_access_control_origin_type = "s3"
  signing_behavior                  = "always"
  signing_protocol                  = "sigv4"
}

resource "aws_cloudfront_cache_policy" "cache" {
  name        = var.aws_cloudfront_cache_policy_name
  comment     = "test comment"
  min_ttl                = var.min_ttl
  default_ttl            = var.default_ttl
  max_ttl                = var.max_ttl
  parameters_in_cache_key_and_forwarded_to_origin {
    cookies_config {
      cookie_behavior = "whitelist"
      cookies {
        items = ["example"]
      }
    }
    headers_config {
      header_behavior = "whitelist"
      headers {
        items = ["example"]
      }
    }
    query_strings_config {
      query_string_behavior = "whitelist"
      query_strings {
        items = ["example"]
      }
    }
  }
}