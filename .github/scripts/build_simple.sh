#!/bin/bash

set -e

echo $PWD
# Get relative path to PWD and generate dashed name from it
echo "${prefix} -t ${container} ${context}"
${prefix} -t ${container} ${context}
echo "uri=${container}" >> $GITHUB_OUTPUT
basedir=$(dirname $filename)
echo "dockerfile_dir=${basedir}" >> $GITHUB_OUTPUT
