This contains a FluxCD configuration that is watched by a local microk8s cluster.

# Addons

The following addons must be enabled and configured:

## Host Access
https://microk8s.io/docs/addon-host-access

This exposes the host machine to k8s services at IP address `10.0.1.1`.

# Secrets

Secrets are encrypted with SOPS and committed to the git repository. To do this, create a normal k8s secret, and then run:

```sh
sops --encrypt --in-place secret.yaml
```
