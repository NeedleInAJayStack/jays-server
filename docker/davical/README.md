# DAViCal

## Upgrade Schema
This is sometimes necessary after pulling a new DAViCal docker image

```bash
docker exec -it davical bash  						# Log into shell in Docker image
cd /usr/share/davical
export PGPASSWORD=<password>							# Set PostgreSQL password
dba/update-davical-database --dbhost davical_db --dbname davical --dbuser postgres --appuser davical_app --owner davical_dba	# Run update script
```
Be careful with this though - It can assign ownership to new items to `postgres` incorrectly.
