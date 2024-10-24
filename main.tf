terraform {
  required_providers {
    digitalocean = {
      source  = "digitalocean/digitalocean"
      version = "~> 2.0"
    }
  }
}

# Configure the DigitalOcean Provider
provider "digitalocean" {
  token = var.do_token
}

# Create a new Droplet (VM)
resource "digitalocean_droplet" "web1" {
  name   = "${var.droplet_name}-1"
  region = var.region
  size   = var.size
  image  = var.image
  tags   = var.tags

  # Optional: Configure SSH key
  ssh_keys = [var.ssh_fingerprint]
}

resource "digitalocean_droplet" "web2" {
  name   = "${var.droplet_name}-2"
  region = var.region
  size   = var.size
  image  = var.image
  tags   = var.tags

  # Optional: Configure SSH key
  ssh_keys = [var.ssh_fingerprint]
}

resource "digitalocean_loadbalancer" "web_lb" {
  name   = "example-lb"
  region = var.region

  forwarding_rule {
    entry_protocol  = "http"
    entry_port      = 80
    target_protocol = "http"
    target_port     = 80
  }

  healthcheck {
    protocol                 = "http"
    port                     = 80
    path                     = "/"
    check_interval_seconds   = 10
    response_timeout_seconds = 5
    healthy_threshold        = 5
    unhealthy_threshold      = 3
  }

  droplet_ids = [digitalocean_droplet.web1.id, digitalocean_droplet.web2.id]
  depends_on  = [digitalocean_droplet.web1, digitalocean_droplet.web2]
}
