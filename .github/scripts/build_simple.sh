#!/bin/bash

set -e

echo $PWD
basedir=$(dirname $filename)
printf "Base directory is ${basedir}\n"
# Get relative path to PWD and generate dashed name from it
echo "${prefix} -t ${container} ."
${prefix} -f $filename -t ${container} .

echo "uri=${container}" >> $GITHUB_OUTPUT
echo "dockerfile_dir=${basedir}" >> $GITHUB_OUTPUT
