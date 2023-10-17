#!/bin/bash

docker run \
  --volume=/var/lib/drone:/data \
  --env=DRONE_GITHUB_CLIENT_ID= \
  --env=DRONE_GITHUB_CLIENT_SECRET= \
  --env=DRONE_RPC_SECRET= \
  --env=DRONE_SERVER_HOST= \
  --env=DRONE_SERVER_PROTO=https \
  --publish=80:80 \
  --publish=443:443 \
  --restart=always \
  --detach=true \
  --name=drone \
  drone/drone:2