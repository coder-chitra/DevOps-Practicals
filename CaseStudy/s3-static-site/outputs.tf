output "website_url" {
  description = "URL of the static website"
  value       = "http://${aws_s3_bucket_website_configuration.site.website_endpoint}"
}

output "bucket_name" {
  value = aws_s3_bucket.site.id
}

AWSTemplateFormatVersion: "2010-09-09"
