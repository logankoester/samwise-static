project = "samwise-static"

runner {
  enabled = true
  data_source "git" {
    url  = "https://github.com/logankoester/samwise-static.git"
    #path = "docker/static"
  }
}

# Labels can be specified for organizational purposes.
# labels = { "foo" = "bar" }

app "samwise-static" {
  labels = {
    "service" = var.name
    "env" = "dev"
  }

  build {
    use "docker" {
    }
  }

  deploy {
    use "docker" {
      labels = {
        "traefik.http.routers.${var.name}.rule" = "Host(`${var.name}.waypoint.smaug.dev`)"
        "traefik.http.routers.${var.name}.entrypoints" = "websecure"
        "traefik.http.routers.${var.name}.tls.certresolver" = "myresolver"
        "traefik.http.services.${var.name}.loadbalancer.server.port" = "3000"
      }
    }
  }
}


variable "name" {
  type = string
  default = "samwise-static"
  description = "Project name"
}
