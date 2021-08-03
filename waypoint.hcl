project = "nginx-project"

runner {
  enabled = true
  data_source "git" {
    url  = "https://github.com/hashicorp/waypoint-examples.git"
    path = "docker/static"
  }
}

# Labels can be specified for organizational purposes.
# labels = { "foo" = "bar" }

app "nginx-project" {
  labels = {
    "service" = "nginx-project"
    "env" = "dev"
  }

  build {
    use "docker" {
#	buildkit = true
	#platform = "linux/amd64"
	#disable_entrypoint = true
    }
  }

  deploy {
    use "docker" {
      labels = {
        "traefik.http.routers.nginx-project.rule" = "Host(`nginx-project.waypoint.smaug.dev`)"
        "traefik.http.routers.nginx-project.entrypoints" = "websecure"
        "traefik.http.routers.nginx-project.tls.certresolver" = "myresolver"
        "traefik.http.services.nginx-project.loadbalancer.server.port" = "3000"
      }
    }
  }
}
