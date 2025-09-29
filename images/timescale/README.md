Builds a Timescale image with non-OSS support for aggregation functions. Background here: https://github.com/CrunchyData/postgres-operator/issues/2692

To build, run:
```
docker buildx build \
  --build-arg CRUNCHYDATA_TAG=ubi9-16.10-2534 \
  --tag ghcr.io/needleinajaystack/jays-server/timescaledb:16.10-2534 \
  .
```

