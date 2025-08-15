#!/bin/bash

set -e

DOCKERHUB_USER="ashok2102"
BRANCH_NAME=$1
TAG=$2


if [ "$BRANCH_NAME" == "main" ]; then
  REPO_NAME="prod"
else
  REPO_NAME="dev"
fi

IMAGE_NAME="${DOCKERHUB_USER}/${REPO_NAME}:${TAG}"

echo "Building Docker image for $BRANCH_NAME"
sudo docker build -t ${REPO_NAME}:$TAG .

echo "Tag $IMAGE_NAME"
sudo docker tag ${REPO_NAME}:$TAG ${IMAGE_NAME}

echo "Pushing Image to DockerHub $REPO_NAME"
sudo docker push "$IMAGE_NAME"

echo "$IMAGE_NAME Push to DockerHub Done!"
