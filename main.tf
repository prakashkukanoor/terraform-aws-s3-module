locals {
  common_tags = {
    environment = var.environment
    managedBy   = var.team
    createdBy   = "terraform"
  }
}

# Create s3 bucket
resource "aws_s3_bucket" "this" {
  count = length(var.bucket_names)
  region = var.region

  bucket = var.bucket_names[count.index] # Replace with your bucket name

  tags = local.common_tags
}

# Block public access settings
resource "aws_s3_bucket_public_access_block" "this" {
  count = length(var.bucket_names)

  bucket = aws_s3_bucket.this[count.index].id

  block_public_acls       = var.block_public_acls
  block_public_policy     = var.block_public_policy
  ignore_public_acls      = var.ignore_public_acls
  restrict_public_buckets = var.restrict_public_buckets
}

# Enable versioning
resource "aws_s3_bucket_versioning" "this" {
  count = length(var.bucket_names)

  bucket = aws_s3_bucket.this[count.index].id
  versioning_configuration {
    status = "Enabled"
  }
}

# Server-side encryption configuration
resource "aws_s3_bucket_server_side_encryption_configuration" "this" {
  count = length(var.bucket_names)

  bucket = aws_s3_bucket.this[count.index].id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

# Attach iam policy to the s3
resource "aws_s3_bucket_policy" "this" {
  count  = length(var.bucket_names)
  bucket = aws_s3_bucket.this[count.index].id

  policy = jsondecode(templatefile("${var.path_to_json_file}", {
    bucket_id = aws_s3_bucket.this[count.index].id
  }))

}