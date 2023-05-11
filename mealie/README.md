# Mealie

## Kubernetes
To run with Kubernetes, install using:

```bash
kubectl create -f mealie/kubernetes.yaml
```

Then to open a web browser:

```bash
minikube service mealie-entrypoint
```