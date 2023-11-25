# Netdata

https://learn.netdata.cloud/docs/

## Kubernetes

https://learn.netdata.cloud/docs/installation/install-on-specific-environments/kubernetes/

```bash
helm repo add netdata https://netdata.github.io/helmchart/
helm install -f values.yaml netdata netdata/netdata
```

Create the namespace:

```bash
kubectl create namespace davical
```

Create the secret from .env:

```bash
kubectl create secret generic davical-secrets \
  --namespace davical \
  --from-env-file=davical/.env
```

Deploy it:

```bash
kubectl create \
  --namespace davical \
  --filename davical/kubernetes.yaml
```