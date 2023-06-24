terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "3.0.2"
    }
  }
}

resource "docker_image" "server_image" {
  name = "server_image"
    build {
      context = "../server"
      tag     = ["app:server"]
    }
}

resource "docker_image" "client_image" {
  name = "clientr_image"
    build {
      context = "../client"
      tag     = ["app:client"]
    }
}

resource "docker_container" "client-container" {
  name  = "client_app"
  image =  docker_image.client_image.name
  ports {
   internal = "3000"
   external = "3002"
 }
}

resource "docker_container" "server-container" {
  name  = "server_app"
  image =  docker_image.server_image.name
  ports {
   internal = "3000"
   external = "3001"
 }
}
