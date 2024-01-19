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
      module.bucket["cfhost123"].s3_bucket_arn[0],
      "${module.bucket["cfhost123"].s3_bucket_arn[0]}/*",
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
      module.bucket["cflogger123"].s3_bucket_arn[0],
      "${module.bucket["cflogger123"].s3_bucket_arn[0]}/*",
    ]
  }
}