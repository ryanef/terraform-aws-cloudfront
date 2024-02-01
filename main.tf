module "bucket" {
  source  = "app.terraform.io/ryanf/bucket/s3"
  version = "1.1.0"
  # insert required variables here
  bucket_tag_name = "firstoneweds"
  bucket_name = "wedsswedzz11"
  bucket_name_log = "wedsloglogqqw"
}
resource "aws_s3_bucket_policy" "cf_bucket" {
  bucket = module.bucket.s3_bucket_id
  policy = data.aws_iam_policy_document.cf_bucket.json
}

resource "aws_cloudfront_distribution" "distribution" {
 
  origin {
    domain_name              = module.bucket.s3_bucket_domain_name
    origin_access_control_id = aws_cloudfront_origin_access_control.oac.id
    origin_id                = var.s3_origin_id
  }

  enabled             = true
  is_ipv6_enabled     = true
  comment             = "comment"
  default_root_object = var.default_root_object

  dynamic "logging_config" {
    for_each =  var.logging_config

    content {
      bucket          = logging_config.value["bucket"]
      prefix          = lookup(logging_config.value, "prefix", null)
      include_cookies = lookup(logging_config.value, "include_cookies", null)
    }
  }

  # aliases = ["mysite.example.com", "yoursite.example.com"]

  default_cache_behavior {
    allowed_methods  = ["DELETE", "GET", "HEAD", "OPTIONS", "PATCH", "POST", "PUT"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = var.s3_origin_id

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
    target_origin_id = var.s3_origin_id
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