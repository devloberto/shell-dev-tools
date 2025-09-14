#!/bin/bash

# setup docker group to match the host's docker socket group
DOCKER_GID=$(stat -c '%g' /var/run/docker.sock)
if ! getent group docker >/dev/null; then
  sudo groupadd -g "$DOCKER_GID" docker
else
  sudo groupmod -g "$DOCKER_GID" docker
fi
sudo usermod -aG docker dev # and add 'dev' user to docker group

# keep the container running
tail -f /dev/null
