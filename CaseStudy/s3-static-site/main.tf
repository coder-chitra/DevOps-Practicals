terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.0"
    }
  }
}

provider "aws" {
  region = var.region
}

# Bucket names are global, so add a random suffix to keep it unique
resource "random_id" "suffix" {
  byte_length = 4
}

locals {
  mime_types = {
    ".html" = "text/html"
    ".css"  = "text/css"
    ".js"   = "application/javascript"
    ".png"  = "image/png"
    ".jpg"  = "image/jpeg"
    ".svg"  = "image/svg+xml"
  }
}

# 1. Create the S3 bucket
resource "aws_s3_bucket" "site" {
  bucket = "${var.bucket_prefix}-${random_id.suffix.hex}"
}

resource "aws_s3_bucket_website_configuration" "site" {
  bucket = aws_s3_bucket.site.id

  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "error.html"
  }
}

# 3a. Allow a public bucket policy (turn off Block Public Access for this bucket)
resource "aws_s3_bucket_public_access_block" "site" {
  bucket                  = aws_s3_bucket.site.id
  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

# 3b. Bucket policy: public read for every object
resource "aws_s3_bucket_policy" "public_read" {
  bucket     = aws_s3_bucket.site.id
  depends_on = [aws_s3_bucket_public_access_block.site]

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Sid       = "PublicReadGetObject"
      Effect    = "Allow"
      Principal = "*"
      Action    = "s3:GetObject"
      Resource  = "${aws_s3_bucket.site.arn}/*"
    }]
  })
}

# 2. Upload every file in ./website
resource "aws_s3_object" "files" {
  for_each     = fileset("${path.module}/website", "**")
  bucket       = aws_s3_bucket.site.id
  key          = each.value
  source       = "${path.module}/website/${each.value}"
  etag         = filemd5("${path.module}/website/${each.value}")
  content_type = lookup(local.mime_types, regex("\\.[^.]+$", each.value), "application/octet-stream")
}