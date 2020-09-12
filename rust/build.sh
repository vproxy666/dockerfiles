#!/bin/bash
IMAGE_URI="vproxy/ci-rust:$(date +'%Y%m%d%H%M')"
docker build -t $IMAGE_URI .
docker login -u $DOCKERHUB_USERNAME -p $DOCKERHUB_PASSWORD
docker push $IMAGE_URI