ARG CRUNCHYDATA_TAG

# Find containers here: https://www.crunchydata.com/developers/download-postgres/containers
# Example: CRUNCHYDATA_TAG=ubi9-16.10-2534
FROM registry.developers.crunchydata.com/crunchydata/crunchy-postgres:${CRUNCHYDATA_TAG}
USER root
RUN curl -sSL -o /etc/yum.repos.d/timescale_timescaledb.repo "https://packagecloud.io/install/repositories/timescale/timescaledb/config_file.repo?os=el&dist=8" && \
    microdnf update -y && \
    # Find available versions here: https://packagecloud.io/timescale/timescaledb
    microdnf install -y timescaledb-2-postgresql-16 && \
    microdnf install -y timescaledb-toolkit-postgresql-16 && \
    microdnf clean all
USER 26

