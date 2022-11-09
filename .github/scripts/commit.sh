#!/bin/bash

set -e

printf "GitHub Actor: ${GITHUB_ACTOR}\n"
git config user.name "github-actions"
git config user.email "github-actions@users.noreply.github.com"
git fetch || printf "fetch did not work\n"
git checkout main || printf "Already on main!\n"

# Add all results!
for row in $(echo "${result}" | jq -r '.[] | @base64'); do
  _jq() {
    echo ${row} | base64 --decode | jq -r ${1};}
    git add $(_jq '.name')
done

set +e
git status | grep modified
if [ $? -eq 0 ]; then
  set -e
  printf "Changes\n"
  git commit -a -m "Automated push to update ${result_name} $(date '+%Y-%m-%d')" || exit 0
  git push origin main
else
 set -e
 printf "No changes\n"
fi
