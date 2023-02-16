#! /bin/bash
pg_dump -Ft -h localhost -U postgres -f ~/Data/db/health.tar health
pg_dump -Ft -h localhost -U postgres -f ~/Data/db/particle.tar particle
