locals {
  s3_origin_id = var.s3_origin_id
  log_bucket_id = module.bucket.s3_log_bucket_id
}