variable "default_root_object" {
  description = "s3 bucket default object"
  type = string
  default = "index.html"
}
variable "environment" {
  default = "devcf"
  type = string
}
variable "default_cache_cookies_forward" {
  type = string
  default = true
}
variable "price_class" {
  default = "PriceClass_200"
  type = string
}
variable "host_bucket_id" {}

variable "s3_log_bucket" {
  default = ""
}
variable "log_bucket_arn"{}
variable "host_bucket_arn"{}

variable "log_bucket_id"{}
variable "s3_bucket_domain" {}
variable "s3_origin_id" {}
variable "log_bucket_domain" {}
variable "bucket_ownership_control" {
  default = "BucketOwnerPreferred"
  type = string
}
variable bucket_acl_permission {
  type = string
  default = "FULL_CONTROL"
}

variable "viewer_protocol_policy" {
  default = "redirect-to-https"
  type = string
}

variable "aliases" {
  type = list(string)
  description = "[\"mysite.example.com\", \"yoursite.example.com\"]"
  default = []
}

variable "query_string" {
  default = false
  type = bool
}

variable "min_ttl"{
  default = 0
  type = number
}

variable "default_ttl"{
  default = 3600
  type = number
}

variable "max_ttl"{
  default = 86400
  type = number
}

variable "compress" {
  default = true
  type = bool
}

variable "oac_name" {
  default = "tfanoacname"
  type = string
}

variable "aws_cloudfront_cache_policy_name" {
  default = "tfcachepolicy"
  type = string
}