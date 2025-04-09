variable "bucket_names" {
  description = "Name for the S3 bucket"
  type        = list(string)
}

variable "path_to_json_tpl_file" {
  type        = string
  description = "Name of the tpl file with policy"
}
variable "region" {
  type        = string
  description = "region for bucket creation"
}


variable "environment" {
  type = string
}
variable "team" {
  type = string
}

variable "block_public_acls" {
  type    = bool
  default = true

}

variable "block_public_policy" {
  type    = bool
  default = true

}

variable "ignore_public_acls" {
  type    = bool
  default = true

}
variable "restrict_public_buckets" {
  type    = bool
  default = true

}