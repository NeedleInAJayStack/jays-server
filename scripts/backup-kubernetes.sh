#! /bin/bash

# Copies each directory in `/var/openebs/local/` to a directory in `~/backup/kubernetes/openebs/`.
# It should be run on a scheduled cadence via the root cron to avoid permissions issues.
#
# The backup directory is locally backed up and versioned to separate disk using duplicity (Ubuntu backup), and
# synchronized automatically via Syncthing with the remote backup.
# This approach was chosen over zip archives to reduce network traffic. It allows Syncthing to perform small incremental
# syncing instead of many transfers of large archives that may have minimal changes.

set -euo pipefail

source_dir=/var/openebs/local/
destination_dir=/home/jay/backup/kubernetes/openebs
owner=jay
lock_file=/run/lock/backup-kubernetes.lock

exec 9>"$lock_file"
if ! flock -n 9; then
  printf 'Another backup is already running\n' >&2
  exit 1
fi

echo "Starting backup of $source_dir"
cd "$source_dir"
for dir in */; do
  destination="$destination_dir/$dir"
  echo "Backing up $dir to $destination"
  rsync --archive --atimes --chown="$owner:$owner" --delete --delete-delay "$dir" "$destination"
done
echo "Backup complete"
