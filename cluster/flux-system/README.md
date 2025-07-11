# Flux System
This directory contains the configuration for the Flux system, which is used to manage the deployment of applications and services in a Kubernetes cluster.

## Getting Started

See: https://fluxcd.io/flux/installation/bootstrap/github/

Create a personal access token, and run:

```bash
export GITHUB_TOKEN=<gh-token>
flux bootstrap github \
  --owner=NeedleInAJayStack \
  --repository=jays-server \
  --branch=main \
  --path=cluster \
  --personal
```

To update the personal access token used by Flux (like after expiration), just regenerate the token, delete the `flux-system` secret, and run the commands above again.

## Secrets

I use SOPS and OpenPGP to encrypt and commit the secrets to the git repository. For configuration, see the [Flux guide](https://fluxcd.io/flux/guides/mozilla-sops/). In particular, this is controlled by a manually created secret named `sops-gpg` in the `flux-system` namespace, and the `decryption` section of the `flux-system` kustomization in `./gotk-sync.yaml`.
