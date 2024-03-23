#!/bin/bash
set -e
unixts=$(date +%s)
tag=docker.io/rdbell/pgquarrel
echo "Building pgquarrel..."
docker build -t pgquarrel --platform linux/amd64 .
echo "Tagging pgquarrel..."
docker tag pgquarrel $tag:$unixts
docker tag pgquarrel $tag:latest
echo "Pushing $tag:$unixts..."
docker push $tag:$unixts
echo "Pushing $tag:latest..."
docker push $tag:latest

