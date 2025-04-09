locals {
  common_tags = {
    environment = var.environment
    managedBy   = var.team
    createdBy   = "terraform"
  }

  # bucket_policies = {
  #   for bucket_name, bucket_resource in aws_s3_bucket.this :
  #   bucket_name => templatefile("${var.path_to_tpl_file}", {
  #     bucket_name     = bucket_resource.id
  #     vpc_endpoint_id = var.vpc_endpoint_id
  #   })
  # }
}

# Create s3 bucket
resource "aws_s3_bucket" "this" {
  for_each = toset(var.bucket_names)
  
  bucket = each.key
  tags = local.common_tags
}

# Block public access settings
resource "aws_s3_bucket_public_access_block" "this" {
  for_each = toset(var.bucket_names)

  bucket = aws_s3_bucket.this[each.key].id

  block_public_acls       = var.block_public_acls
  block_public_policy     = var.block_public_policy
  ignore_public_acls      = var.ignore_public_acls
  restrict_public_buckets = var.restrict_public_buckets
}

# Enable versioning
resource "aws_s3_bucket_versioning" "this" {
  for_each = toset(var.bucket_names)

  bucket = aws_s3_bucket.this[each.key].id
  versioning_configuration {
    status = "Enabled"
  }
}

# Server-side encryption configuration
resource "aws_s3_bucket_server_side_encryption_configuration" "this" {
  for_each = toset(var.bucket_names)

  bucket = aws_s3_bucket.this[each.key].id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

# Attach iam policy to the s3
# resource "aws_s3_bucket_policy" "this" {
#   for_each = toset(var.bucket_names)

#   bucket = aws_s3_bucket.this[each.key].id

#   policy = jsondecode(templatefile("${var.path_to_json_file}", {
#     bucket_id = aws_s3_bucket.this[count.index].id
#   }))

# }