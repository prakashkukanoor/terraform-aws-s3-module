
output "buckets" {
  value = [for s3_obj in aws_s3_bucket.this : s3_obj.bucket]
}

output "flattened" {
  value = local.applications_data
}