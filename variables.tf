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
}
variable "price_class" {
  default = "PriceClass_200"
  type = string
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
  default = "anoacname"
  type = string
}

variable "aws_cloudfront_cache_policy_name" {
  default = "defcachepolicy"
  type = string
}