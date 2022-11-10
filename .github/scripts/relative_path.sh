#!/bin/bash

set -e

echo "Original path is $filename"
echo "Original container is $container"
relative=$(echo ${filename/\/github\/workspace\//})
echo "Relative path is $relative"
echo "relative_path=${relative}" >> $GITHUB_OUTPUT
container=$(echo "${container/bases-/""}")
echo "container=${container}" >> $GITHUB_OUTPUT


