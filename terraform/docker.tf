variable "name" {
  type = string
}

terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 2.13.0"
    }
  }
}

provider "docker" {}

resource "docker_image" "nginx" {
  name         = "nginx:latest"
  keep_locally = false
}

resource "docker_container" "nginx" {
  image = docker_image.nginx.latest
  name  = var.name
  ports {
    internal = 80
    external = 8000
  }
}

output "docker_ip_address" {
  value = docker_container.nginx.ip_address
}