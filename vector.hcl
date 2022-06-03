template "vector_config" {
  source      = <<EOF
  [api]
  enabled = false

  [sources.events]
  type = "http"
  address = "0.0.0.0:6000"

  [sources.events.decoding]
  codec = "json"

  [sinks.out]
  inputs = ["events"]
  type = "file"
  path = "/data/events.json"
  compression = "none"
  encoding.codec = "text"
  EOF
  destination = "${data("vector_config")}/vector.toml"
}

container "vector" {
  depends_on = ["template.vector_config"]

  image {
    name = "timberio/vector:0.14.X-alpine"
  }

  volume {
    source      = "${data("vector_config")}/data/"
    destination = "/data/"
  }

  volume {
    source      = "${data("vector_config")}/vector.toml"
    destination = "/etc/vector/vector.toml"
  }

  network {
    name = "network.cloud"
  }

  port {
    local  = 6000
    remote = 6000
    host   = 6000
  }
}