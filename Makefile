.PHONY: all

all:
	docker build -t idrive-docker .

run:
	docker run \
		--name idrive-docker \
		--hostname idrive-x1c7-docker \
		--mac-address="02:43:ac:36:ea:e3" \
		-d \
		-e PGID=$$(id -g) \
		-e PUID=$$(id -u) \
		-v /:/backup:ro \
		idrive-docker

kill:
	docker kill idrive-docker
	docker rm idrive-docker

shell:
	docker exec -it idrive-docker /bin/bash