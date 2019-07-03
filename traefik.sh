#!bin/bash

#crear la red overlay
docker network create --driver=overlay proxy-net

#lanzar traefilk
docker service create \
    --name traefik \
    --constraint=node.role==manager \
    --publish 80:80 --publish 443:443 --publish 8080:8080 \
    --mount type=bind,source=/var/run/docker.sock,target=/var/run/docker.sock \
    --network proxy-net \
      traefik:latest \
    --docker \
    --docker.swarmMode \
    --docker.domain=twcam.tk \
    --docker.watch \
    --api

#docker service update --replicas=5 api_busqueda
#docker service update --update-parallelism 4 --update-order start-first api_pago
#docker service update -d --env-add UNAVARIABLE=UNO --update-parallelism 0 api_mysql
