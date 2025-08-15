#!/bin/bash

set -e

DOCKERHUB_USER="ashok2102"
DEV_REPO="dev"
PROD_REPO="prod"
BRANCH="${BRANCH}"
TAG="${VERSION:-v1}"

if [[ "$BRANCH" == "main" ]]; then
  REPO="$PROD_REPO"
else
  REPO="$DEV_REPO"
fi

IMAGE="$DOCKERHUB_USER/$REPO:$TAG"

echo "Building Image $IMAGE"
sudo docker build -t "$IMAGE" .

echo "Pushing Image to DockerHub $REPO"
sudo docker push "$IMAGE"

echo "Image Build & Push to DockerHub Done!"
