#! /bin/bash

# Copies each directory in `~/Data/docker/` to a directory in `~/backup/`.
# The backup directory is synchronized automatically via Syncthing with the remote backup.
# This approach was chosen over zip archives to reduce network traffic. It allows Syncthing to perform small incremental
# syncing instead of many transfers of large archives that may have minimal changes.

set -euo pipefail

docker_dir=~/Data/docker/
destination_dir=~/backup

echo "Starting backup of $docker_dir"
cd $docker_dir
for dir in */; do
  destination=$destination_dir/$dir
  echo "Backing up $dir to $destination"
  rsync -r "$dir" "$destination_dir/$dir"
done;
echo "Backup complete"
