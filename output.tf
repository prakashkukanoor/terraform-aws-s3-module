output "buckets" {
  value = aws_s3_bucket.this[*].bucket
}

# output "application_public_subnets" {
#   value = aws_subnet.application_public[*].id
# }

# output "application_private_subnets" {
#   value = aws_subnet.application_private[*].id
# }

# output "database_private_subnets" {
#   value = aws_subnet.database_private[*].id
# }