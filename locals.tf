locals {
    s3_origin_id = "tuezzz"
    s3_bucket_domain = module.bucket["hostbucket12366"].s3_bucket_domain_name

    host_bucket_arn = module.bucket["hostbucket12366"].s3_bucket_arn
    host_bucket_id = module.bucket["hostbucket12366"].s3_bucket_id

    log_bucket_arn = module.bucket["logbucket12366"].s3_bucket_arn
    log_bucket_id = module.bucket["logbucket12366"].s3_bucket_id
    log_bucket_domain = module.bucket["logbucket12366"].s3_bucket_domain_name
    buckets = {
      hostbucket12366 = {
        bucket_tag_name = "tuezz"
        environment = "dev"
        s3_force_destroy = true
      }
      logbucket12366 = {
        bucket_tag_name = "tuezzlog"
        environment = "dev"
        s3_force_destroy = true
      }
    }
}
