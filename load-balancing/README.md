# Load Balancing

Achieved via [nginx ingress](https://kubernetes.github.io/ingress-nginx)

To expose ingresses to the host, use:

```bash
kubectl port-forward --namespace=ingress-nginx service/ingress-nginx-controller <desired_port>:80
```

## TLS

This should be configured locally using the `kubectl` cli:

```bash
kubectl create secret tls jayherron-cert --key ${KEY_FILE} --cert ${CERT_FILE}
```

If not configured, make sure to comment out the TLS section of the ingress

