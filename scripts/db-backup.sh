#! /bin/bash
pg_dump -Ft -h localhost -U postgres -f ~/Data/db/health.tar health
pg_dump -Ft -h localhost -U postgres -f ~/Data/db/timeseries_api.tar timeseries_api
