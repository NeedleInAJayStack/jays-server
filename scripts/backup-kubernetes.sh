#! /bin/bash

# Copies each directory in `/var/openebs/local/` to a directory in `~/backup/kubernetes/openebs/`.
# The backup directory is synchronized automatically via Syncthing with the remote backup.
# This approach was chosen over zip archives to reduce network traffic. It allows Syncthing to perform small incremental
# syncing instead of many transfers of large archives that may have minimal changes.

set -euo pipefail

source_dir=/var/openebs/local/
destination_dir=~/backup/kubernetes/openebs

echo "Starting backup of $source_dir"
cd $source_dir
for dir in */; do
  destination=$destination_dir/$dir
  echo "Backing up $dir to $destination"
  rsync -r "$dir" "$destination_dir/$dir"
done;
echo "Backup complete"
