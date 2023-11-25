# Traefik

Ingress that serves different applications

## Kubernetes

### Set up cert-manager

https://github.com/traefik/traefik-helm-chart/blob/master/EXAMPLES.md#provide-default-certificate-with-cert-manager-and-cloudflare-dns

https://doc.traefik.io/traefik/v1.7/user-guide/kubernetes/

```bash
# Install Traefik Resource Definitions:
kubectl apply -f https://raw.githubusercontent.com/traefik/traefik/v2.10/docs/content/reference/dynamic-configuration/kubernetes-crd-definition-v1.yml

# Install RBAC for Traefik:
kubectl apply -f https://raw.githubusercontent.com/traefik/traefik/v2.10/docs/content/reference/dynamic-configuration/kubernetes-crd-rbac.yml
```

```bash
minikube addons enable ingress
```

Install certbot CRD:
```bash
kubectl apply -f https://github.com/cert-manager/cert-manager/releases/download/v1.1.1/cert-manager.yaml
```

Create traefik namespace:

```bash
kubectl create namespace traefik
```


Create the secret from .env:

```bash
kubectl create secret generic cloudflare \
  --namespace traefik \
  --from-env-file=traefik/.env
```

Start cert manager and get certificates

```bash
kubectl create -f traefik/kubernetes.yaml
```

Check that it's ready

```bash
kubectl get certificate -n traefik
```

### traefik

Install traefik

```bash
helm install traefik traefik/traefik
helm install -f values.yaml traefik traefik/traefik
```