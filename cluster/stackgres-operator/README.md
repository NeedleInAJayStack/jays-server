# StackGres Operator
https://stackgres.io/

StackGres was chosen as a PostgreSQL operator because it has first-class support for the Community Licensed TimescaleDB extension ([`timescale-tsl`](https://stackgres.io/doc/latest/intro/extensions/)).

## Timescale Management

Reference the [timescaledb/postgres compatibility matrix](https://docs.tigerdata.com/self-hosted/latest/upgrades/upgrade-pg/#plan-your-upgrade-path). You MUST stay in the green checkmarks. Horizontal (postgres) and vertical (timescale) upgrades must be done independently.

Note that StackGres Timescale support often lags behind.

### Upgrading Timescale
Modified from instructions [here](https://docs.tigerdata.com/self-hosted/latest/upgrades/upgrade-docker/)
```bash
# !! Manually change the timescaledb version in the SGCluster resource

# Connect to the cluster
kubectl exec -it cluster-0 -- psql
# For each relevant database, update the timescaledb extension
ALTER EXTENSION timescaledb UPDATE;
```

### Upgrading Postgres
Follow StackGres instructions, while maintaining the same TimescaleDB version.
