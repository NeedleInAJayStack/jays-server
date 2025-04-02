# Flux System
This directory contains the configuration for the Flux system, which is used to manage the deployment of applications and services in a Kubernetes cluster.

## Getting Started

See: https://fluxcd.io/flux/installation/bootstrap/github/

Create a personal access token, and run:

```bash
export GITHUB_TOKEN=<gh-token>
flux bootstrap github \
  --token-auth \
  --owner=NeedleInAJayStack \
  --repository=jays-server \
  --branch=main \
  --path=cluster \
  --personal
```

To update the personal access token used by Flux (like after expiration), just regenerate the token, delete the `flux-system` secret, and run the commands above again.
