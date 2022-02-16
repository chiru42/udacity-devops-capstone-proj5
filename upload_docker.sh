#!/usr/bin/env bash
# This file tags and uploads an image to Docker Hub

# Assumes that an image is built via `run_docker.sh`

# Step 1:
# Create dockerpath
# dockerpath=<your docker ID/path>
dockerpath='chiru42/flaskapi:latest'

# Step 2:  
# Authenticate & tag
docker login -u $docker_USERNAME -p $docker_PASSWORD
echo "Docker ID and Image: $dockerpath"

# Step 3:
# Push image to a docker repository
# docker tag local-image:tagname new-repo:tagname
# docker push new-repo:tagname
docker tag flaskapi:latest chiru42/flaskapi:latest
docker push chiru42/flaskapi:latest

docker logout
