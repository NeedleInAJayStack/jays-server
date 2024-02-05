#! /bin/bash

set -euo pipefail

# Backs up the bitwarden data to a `bitwarden.tar.gz` file.
# The backup is stored in the argument directory, or in ~/backup if no argument is provided.
destination=${1-~/backup}
if [ ! -d $destination ]; then
  mkdir $destination
fi
cd ~/Data/docker/bitwarden
tar -czvf $destination/bitwarden.tar.gz .