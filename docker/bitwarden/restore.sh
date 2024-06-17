#! /bin/bash

set -euo pipefail

# Restores the bitwarden data from a `bitwarden.tar.gz` file.
# The backup is located in the argument directory, or in ~/backup if no argument is provided.
source=${1-~/backup}
if [ ! -d $source ]; then
  exit 1
fi
docker-compose down
pushd ~/Data/docker/bitwarden
tar -xzvf $source/bitwarden.tar.gz
popd
docker-compose up -d
