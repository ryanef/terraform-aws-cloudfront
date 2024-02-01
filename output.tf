output "cloudfront_domain" {
  value = aws_cloudfront_distribution.distribution.domain_name
}
output "cloudfront_arn" {
  value = aws_cloudfront_distribution.distribution.arn
}
output "cloudfront_id" {
  value = aws_cloudfront_distribution.distribution.id
}