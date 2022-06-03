env:
	shipyard run

destroy:
	shipyard destroy

ip:
	docker network inspect cloud | jq '.[].Containers | .[] | select(.Name | startswith("server"))'

ingress:
	shipyard taint nomad_ingress.minecraft_server
	shipyard taint nomad_ingress.minecraft_rcon
	shipyard taint nomad_ingress.fake_service
	shipyard taint nomad_ingress.qemu_vnc
	shipyard run