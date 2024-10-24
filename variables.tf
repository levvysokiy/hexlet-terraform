variable "do_token" {
  sensitive = true
}

variable "ssh_fingerprint" {
  description = "SSH key fingerprint"
  type        = string
  sensitive   = true
}

variable "droplet_name" {}
variable "region" {}
variable "size" {}
variable "image" {}
variable "tags" {}
