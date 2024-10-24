terraform {
  required_providers {
    digitalocean = {
      source  = "digitalocean/digitalocean"
      version = "~> 2.0"
    }
  }
}

# Set the variable value in *.tfvars file
# or using -var="do_token=..." CLI option
variable "do_token" {}
variable "ssh_fingerprint" {
  description = "SSH key fingerprint"
  type        = string
}

# Configure the DigitalOcean Provider
provider "digitalocean" {
  token = var.do_token
}

# Create a new Droplet (VM)
resource "digitalocean_droplet" "web" {
  name   = "example-droplet"
  region = "nyc1"             # Choose your region
  size   = "s-1vcpu-1gb"      # Choose your droplet size
  image  = "ubuntu-20-04-x64" # Choose your image

  tags = ["web-server"]

  # Optional: Configure SSH key
  ssh_keys = [var.ssh_fingerprint]
}
