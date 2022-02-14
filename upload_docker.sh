#!/usr/bin/env bash
# This file tags and uploads an image to Docker Hub

# Assumes that an image is built via `run_docker.sh`

# Step 1:
# Create dockerpath
# dockerpath=<your docker ID/path>
dockerpath='chiru42/api:latest'

# Step 2:  
# Authenticate & tag
docker login -u $docker_USERNAME -p $docker_PASSWORD
echo "Docker ID and Image: $dockerpath"
#docker tag local-image:udacity_devops new-repo:udacity_devops
# Step 3:
# Push image to a docker repository
docker push chiru42/api:latest

docker logout
