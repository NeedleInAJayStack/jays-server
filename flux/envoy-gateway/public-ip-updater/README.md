This cron job ensures that `external-dns` DNS records for Envoy are updated with the correct public IP address of this cluster.

How it works:

1. The router is configured to port-forward to the Envoy proxy NodePorts.
2. The CronJob runs every 5 min, curls `ifconfig.me`, and sets the `external-dns.kubernetes.io/target` annotation on the `envoy` Gateway only if changed.
3. `external-dns` (configured with `sources: gateway-httproute`) uses that annotation as the target for every HTTPRoute attached to the Gateway and updates Cloudflare DNS records.
