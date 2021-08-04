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
    "service" = "samwise-static"
    "env" = "dev"
  }

  build {
    use "docker" {
    }
  }

  deploy {
    use "docker" {
      labels = {
        "traefik.http.routers.samwise-static.rule" = "Host(`samwise-static.waypoint.smaug.dev`)"
        "traefik.http.routers.samwise-static.entrypoints" = "websecure"
        "traefik.http.routers.samwise-static.tls.certresolver" = "myresolver"
        "traefik.http.services.samwise-static.loadbalancer.server.port" = "3000"
      }
    }
  }
}
