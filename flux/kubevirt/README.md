# KubeVirt
https://kubevirt.io/

KubeVirt runs virtual machines as Kubernetes pods. Installed via the official
operator + `KubeVirt` CR release manifests, pinned by version in
`kustomization.yaml`.

## Upgrading

Bump both manifest URLs in `kustomization.yaml` to the same release tag from
https://github.com/kubevirt/kubevirt/releases. KubeVirt supports skipping at
most one minor version during upgrades.

## Hardware virtualization

If nodes don't expose `/dev/kvm`, enable software emulation:

```bash
kubectl -n kubevirt patch kubevirt kubevirt --type merge \
  -p '{"spec":{"configuration":{"developerConfiguration":{"useEmulation":true}}}}'
```

## Notes

- VM disks need a default StorageClass — OpenEBS is available in this cluster.
- `virtctl` is the CLI for managing VMs: https://kubevirt.io/user-guide/user_workloads/virtctl/
