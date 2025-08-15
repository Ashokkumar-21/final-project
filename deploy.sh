#!/usr/bin/env bash
set -euo pipefail

DOCKERHUB_USER="ashok2102"
DEV_REPO="dev"
PROD_REPO="prod"
BRANCH="${BRANCH}"
TAG="${VERSION:-V1}"

APP_SERVER_USER="ubuntu"
APP_SERVER_IP="65.2.177.203"

echo "Chose Repo Based Commit"
if [[ "$BRANCH" == "main" ]]; then
  REPO="$PROD_REPO"
else
  REPO="$DEV_REPO"
fi

IMAGE="$DOCKERHUB_USER/$REPO:$TAG"

echo "Deploy $IMAGE to $APP_SERVER_IP"
    docker pull '$IMAGE' &&
    docker rm -f finalapp || true &&
    docker run -itd --name finalapp -p 80:80 --restart unless-stopped '$IMAGE'
"

echo "Final Project Deployment Done! Visit: http://$APP_SERVER_IP/"
