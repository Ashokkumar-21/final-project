#!/usr/bin/env bash
set -euo pipefail

IMAGE="$1"

if [ -z "$IMAGE" ]; then
  echo "Error: Docker image name is required!"
  exit 1
fi

echo "Deploy $IMAGE"
    sudo docker rm -f finalapp || true
    sudo docker pull $IMAGE
    sudo docker run -itd --name finalapp -p 80:80 --restart unless-stopped "$IMAGE"
echo "Final Project Deployment Done!"
