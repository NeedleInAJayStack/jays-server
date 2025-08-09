#! /bin/bash

# Copies each directory in `~/Data/docker/` to a directory in `~/backup/`.
# It should be run on a scheduled cadence via the root cron to avoid permissions issues.
# 
# The backup directory is locally backed up and versioned to separate disk using duplicity (Ubuntu backup), and
# synchronized automatically via Syncthing with the remote backup.
# This approach was chosen over zip archives to reduce network traffic. It allows Syncthing to perform small incremental
# syncing instead of many transfers of large archives that may have minimal changes.

set -euo pipefail

docker_dir=/home/jay/Data/docker/
destination_dir=/home/jay/backup/docker
owner=jay

echo "Starting backup of $docker_dir"
cd $docker_dir
for dir in */; do
  destination=$destination_dir/$dir
  echo "Backing up $dir to $destination"
  rsync --atimes --chown=$owner:$owner --delete --recursive --times "$dir" "$destination_dir/$dir"
done;
echo "Backup complete"
