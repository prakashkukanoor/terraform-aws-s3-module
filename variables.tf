variable "applications" {
  type = map(object({
    buckets                   = list(string)
    policy_json_tpl_file_path = string
  }))
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