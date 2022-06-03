template "consul_agent_config" {
  source      = "${file("${file_dir()}/files/consul_config/agent.hcl")}"
  destination = "${data("consul_config")}/agent.hcl"
}

nomad_cluster "dev" {
  version      = "1.2.0"
  client_nodes = 3

  consul_config = "${data("consul_config")}/agent.hcl"

  network {
    name = "network.cloud"
  }
}

output "NOMAD_ADDR" {
  value = cluster_api("nomad_cluster.dev")
}