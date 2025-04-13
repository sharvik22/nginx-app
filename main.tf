terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "3.0.2"
    }
  }
}

provider "docker" {
  registry_auth {
    address     = "docker.io"
    username    = "sharvik40"
    password    = var.dockerhub_token
  }
}

resource "docker_image" "local" {
  name         = "sharvik40/nginx-app:latest"
  keep_locally = true
}

resource "null_resource" "docker_push" {
  triggers = {
    image_id = docker_image.local.id
  }

  provisioner "local-exec" {
    command = <<-EOT
      docker logout && \
      echo ${var.dockerhub_token} | docker login -u sharvik40 --password-stdin && \
      docker push sharvik40/nginx-app:latest
    EOT
    
    environment = {
      DOCKERHUB_TOKEN = var.dockerhub_token
    }
  }

  depends_on = [docker_image.local]
}
