variable "bucket_name" {
  description = "Name for the S3 bucket"
  type        = string
}

variable "path_to_json_file" {
  type        = string
  description = "Name of the json file with policy"
}

variable "environment" {
  type = string
}
variable "team" {
  type = string
}