variable "applications" {
  type = map(object({
    buckets                   = list(string)
    policy_json_tpl_file_path = string
  }))
  default = {
    "devops-domain" = {
      buckets = ["devops-test"]
      policy_json_tpl_file_path = ""
    }
  }
}

variable "region" {
  type        = string
  description = "region for bucket creation"
  default = "us-east-1"
}


variable "environment" {
  type = string
  default = "DEV"
}
variable "team" {
  type = string
  default = "devops"
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