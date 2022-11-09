#!/bin/bash

set -e

basedir=$(dirname ${result_name})
printf "Base directory is ${basedir}\n"
dockerfile=${result_name}
printf "Dockerfile basename is ${dockerfile}\n"
tag=$(basename ${basedir})
printf "Tag is ${tag}\n"
container=$(basename $(dirname $basedir))          
printf "Container is ${container}\n"
cat ${result_name}
container_name=ghcr.io/rse-ops/${container}:${tag}
docker pull ${container_name} || echo "Container $container_name does not exist yet"
printf "docker build -f ${dockerfile} -t ${container_name} .\n"
docker build -f ${dockerfile} -t ${container_name} .

echo "container_uri=${container_name}" >> $GITHUB_OUTPUT
echo "uri=ghcr.io/rse-ops/${container}" >> $GITHUB_OUTPUT
echo "tag=${tag}" >> $GITHUB_OUTPUT
echo "dockerfile_dir=${basedir}" >> $GITHUB_OUTPUT
