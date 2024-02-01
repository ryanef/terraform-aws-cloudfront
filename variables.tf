variable "create_log_bucket" {
  default = true
}
variable "aws_cloudfront_cache_policy_name" {
  default = "tfcachepolicy"
  type = string
}

variable bucket_acl_permission {
  type = string
  default = "FULL_CONTROL"
}

############################ remove later
variable "bucket_ownership_control" {
  default = "BucketOwnerPreferred"
  type = string
}

variable "compress" {
  default = true
  type = bool
}

variable "default_ttl"{
  default = 3600
  type = number
}

variable "default_root_object" {
  description = "s3 bucket default object"
  type = string
  default = "index.html"
}

variable "default_cache_cookies_forward" {
  type = string
  default = true
}

variable "environment" {
  default = "devcf"
  type = string
}

variable "logging_config" {
  default = {
    
  }
}

variable "min_ttl"{
  default = 0
  type = number
}
variable "max_ttl"{
  default = 86400
  type = number
}

variable "oac_name" {
  default = "tfanoacname"
  type = string
}
variable "price_class" {
  default = "PriceClass_200"
  type = string
}
variable "query_string" {
  default = false
  type = bool
}

variable "s3_log_bucket" {
  default = null
}

variable "s3_bucket_domain" {
  default = null
}

variable "s3_origin_id" {
 default = "mys3originbuck"
}

variable "viewer_protocol_policy" {
  default = "redirect-to-https"
  type = string
}

# variable "aliases" {
#   type = list(string)
#   description = "[\"mysite.example.com\", \"yoursite.example.com\"]"
#   default = []
# }
