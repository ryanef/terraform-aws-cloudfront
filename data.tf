data "aws_caller_identity" "current" {}

data "aws_iam_policy_document" "cf_bucket" {
  statement {
    principals {
      type        = "Service"
      identifiers = ["cloudfront.amazonaws.com"]
    }

    actions = [
      "s3:GetObject",
    ]

    resources = [
      
      module.bucket.s3_bucket_arn,
      "${module.bucket.s3_bucket_arn}/*",
    ]
  }
}

