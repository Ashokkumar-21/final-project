#!/usr/bin/env bash
set -euo pipefail

IMAGE="$1"

echo "Deploy $IMAGE"
    sudo docker pull "$IMAGE" &&
    sudo docker rm -f finalapp || true &&
    sudo docker run -itd --name finalapp -p 80:80 --restart unless-stopped '$IMAGE'
    
echo "Final Project Deployment Done!"
