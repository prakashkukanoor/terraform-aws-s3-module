locals {
  common_tags = {
    environment = var.environment
    managedBy   = var.team
    createdBy   = "terraform"
  }

  applications_data = flatten([
    for domain_name, domain_data in var.applications : [
      for bucket_name in domain_data.buckets : {
        team                  = domain_name
        policy_json_tpl_file_path = domain_data.policy_json_tpl_file_path
        bucket_name           = bucket_name
      }
    ]
  ])
}

# Create s3 bucket
resource "aws_s3_bucket" "this" {
  for_each = {for idx, value in local.applications_data: "${value.bucket_name}" => value }
  
  
  bucket = each.value.bucket_name
  tags = merge(
    local.common_tags,
  { team = "${each.value.team}" })
}

# Block public access settings
# Block public access settings
resource "aws_s3_bucket_public_access_block" "this" {
  for_each = toset([for obj in aws_s3_bucket.this: obj.bucket])

  bucket = aws_s3_bucket.this[each.key].id

  block_public_acls       = var.block_public_acls
  block_public_policy     = var.block_public_policy
  ignore_public_acls      = var.ignore_public_acls
  restrict_public_buckets = var.restrict_public_buckets
}

# # Enable versioning
# resource "aws_s3_bucket_versioning" "this" {
#   for_each = toset(var.bucket_names)

#   bucket = aws_s3_bucket.this[each.key].id
#   versioning_configuration {
#     status = "Enabled"
#   }
# }

# # Server-side encryption configuration
# resource "aws_s3_bucket_server_side_encryption_configuration" "this" {
#   for_each = toset(var.bucket_names)

#   bucket = aws_s3_bucket.this[each.key].id

#   rule {
#     apply_server_side_encryption_by_default {
#       sse_algorithm = "AES256"
#     }
#   }
# }

# Attach iam policy to the s3
# resource "aws_s3_bucket_policy" "this" {
#   for_each = toset(var.bucket_names)

#   bucket = aws_s3_bucket.this[each.key].id

#   policy = jsondecode(templatefile("${var.path_to_json_file}", {
#     bucket_id = aws_s3_bucket.this[count.index].id
#   }))

# }