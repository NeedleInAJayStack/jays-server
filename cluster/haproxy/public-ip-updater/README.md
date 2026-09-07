This cron job ensures that `external-dns` DNS records are updated with the correct public IP address of this cluster.

How it works:

1. The router is configured to port-forward to the haproxy service.
2. The CronJob runs every 5 min, curls `ifconfig.me`, patches `spec.externalIPs` on `haproxy/kubernetes-ingress` only if changed.
3. The HAProxy ingress controller picks up the `externalIPs` change and updates every ingress's `.status.loadBalancer.ingress`.
4. `external-dns` (configured with `sources: ingress`) reads the ingress status and updates Cloudflare DNS records.
