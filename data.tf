data "aws_caller_identity" "current" {}
data "aws_canonical_user_id" "current" {}

data "aws_iam_policy_document" "bucketcf" {
  statement {
    principals {
      type        = "Service"
      identifiers = ["cloudfront.amazonaws.com"]
    }

    actions = [
      "s3:GetObject",
    ]

    resources = [
      
      "${var.host_bucket_arn}",
      "${var.host_bucket_arn}/*",
    ]
  }
}

data "aws_iam_policy_document" "logger" {
  statement {
    principals {
      type        = "Service"
      identifiers = ["cloudfront.amazonaws.com"]
    }

    actions = [
      "s3:GetObjectAcl",
      "s3:PutObjectAcl",
    ]

    resources = [
      "${var.log_bucket_arn}",
      "${var.log_bucket_arn}/*",
    ]
  }
}