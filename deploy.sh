#!/usr/bin/env bash
set -euo pipefail

IMAGE="$1"

echo "Deploy $IMAGE"
    docker pull "$IMAGE" &&
    docker rm -f finalapp || true &&
    docker run -itd --name finalapp -p 80:80 --restart unless-stopped '$IMAGE'
    
echo "Final Project Deployment Done!"
