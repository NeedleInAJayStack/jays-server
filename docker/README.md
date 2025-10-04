# Docker
This is my docker compose stack that runs a few services. It is slowly being moved into the Kubernetes stack in this same repo.

## Upgrading Timescale/Postgres
Reference the [timescaledb/postgres compatibility matrix](https://docs.tigerdata.com/self-hosted/latest/upgrades/upgrade-pg/#plan-your-upgrade-path). You MUST stay in the green checkmarks. Horizontal (postgres) and vertical (timescale) upgrades must be done independently.

### Upgrading Timescale
Modified from instructions [here](https://docs.tigerdata.com/self-hosted/latest/upgrades/upgrade-docker/)
```bash
# !! Manually change the timescaledb service in docker compose to the newest timescale image for the same postgres

# Restart timescale service
docker compose restart timescaledb

# Update the timescaledb extension in postgres
psql -h localhost -U postgres
# For each relevant database:
ALTER EXTENSION timescaledb UPDATE;
```

### Upgrading Postgres
Modified from instructions [here](https://docs.tigerdata.com/self-hosted/latest/backup-and-restore/logical-backup/#back-up-and-restore-an-entire-database)
```bash
# Prepare new working directories for the new database version
cp -R timescaledb timescaledb2
cp -R ~/Data/docker/timescaledb ~/Data/docker/timescaledb2
rm -R ~/Data/docker/timescaledb2/*
cp ~/Data/docker/timescaledb/pg_hba.conf ~/Data/docker/timescaledb2/pg_hba.conf

# !! Manually create timescaledb2 service in docker compose by copying timescaledb, pointing volume mounts to new directories, and changing host port to 5433

docker compose up timescaledb2 -d

# Dumps all databases and user/role info from old database
pg_dumpall -c -h localhost -U postgres -p 5432 -f out.bak

# !! Manually delete any 'postgres' role stuff from the first section of out.bak

# Imports all databases and user/role into new database
psql -h localhost -U postgres -p 5433 -X -f out.bak

# Check that the import worked and data is present
psql -h localhost -U postgres -p 5433
\c timeseries-api
SELECT ts, value FROM his WHERE "pointId" = 'f271e564-dde5-481d-b83e-1840f0b30ace' ORDER BY ts DESC LIMIT 1;

# Get ready for switchover
docker compose down timescaledb timescaledb2

# !! Manually delete timescaledb2 service in docker compose, and update timescaledb service to new image

# Move old data out and new data in
mv ~/Data/docker/timescaledb ~/Data/docker/timescaledb_deleteme
mv timescaledb timescaledb_deleteme
mv ~/Data/docker/timescaledb2 ~/Data/docker/timescaledb
mv timescaledb2 timescaledb

# Bring timescale back up on new image
docker compose up timescaledb -d

# !! Manually check that services still work (in Grafana)

# Clean up old data
rm -R ~/Data/docker/timescaledb_deleteme
rm -R timescaledb_deleteme
rm out.bak
```
