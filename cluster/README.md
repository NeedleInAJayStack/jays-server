This contains a FluxCD configuration that is watched by a local microk8s cluster.

The following addons must be enabled and configured

## Ingress
https://microk8s.io/docs/ingress

Furthermore, the Ingress Controller must avoid overlapping ports with the `docker-compose` `envoy` service in the `docker` folder (since that is our primary reverse proxy). To accomplish this, set the `hostPort`s to `5080` and `5443` in the `nginx-ingress-microk8s-controller` `DaemonSet`. Example:

```yaml
...
        ports:
        - containerPort: 80
          hostPort: 5080
          name: http
          protocol: TCP
        - containerPort: 443
          hostPort: 5443
          name: https
          protocol: TCP
...
```
