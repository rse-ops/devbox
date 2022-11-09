#!/bin/bash

set -e

if [[ "${result}" == "" ]]; then
  result="[]"
fi

if [[ "${result_scheduled}" == "" ]]; then
  result_scheduled="[]"
fi

# Combine results into new output
result=$(python -c "import json; print(json.loads('${result}') + json.loads('${result_scheduled}'))")
if [[ "${result}" == "[]" ]]; then
  printf "The matrix is empty, will not trigger next workflow.\n"
  echo "empty_matrix=true" >> $GITHUB_OUTPUT
else
  printf "The matrix is not empty, and we should continue on to the next workflow.\n"
  echo "empty_matrix=false" >> $GITHUB_OUTPUT
fi
echo ${result}

# set for both workflows that use it
echo "dockerfilelist_matrix=${result}" >> $GITHUB_OUTPUT
echo "dockerbuild_matrix=${result}" >> $GITHUB_OUTPUT
