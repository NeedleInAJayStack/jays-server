# DAViCal

## Upgrade Schema
This is sometimes necessary after pulling a new DAViCal docker image

```bash
docker exec -it davical_app_1 bash  						# Log into shell in Docker image
cd /usr/share/davical
export PGPASSWORD=<password>							# Set PostgreSQL password
dba/update-davical-database --dbhost db --dbname davical --dbuser postgres	# Run upgdate script
```
Be careful with this though - It can assign ownership to new items to `postgres` incorrectly.

## Kubernetes

Create the secret from .env:

```bash
kubectl create secret generic davical-secrets --from-env-file=davical/.env
```

```bash
kubectl create -f davical/kubernetes.yaml
```
