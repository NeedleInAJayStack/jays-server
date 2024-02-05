# Jay's Server

This repo centralizes the docker run configuration for many of the services I run on my server.

## Architecture

Currently, each service exposes a local port on the host machine. Envoy is then used with host networking to provide
local reverse-proxies that map each subdomain to the relevant service port and apply TLS. That is, **the exposed port
of each service and the envoy proxy must match**.