# GKE + Flux GitOps (Terraform)

This repo provisions Kubernetes infrastructure with Terraform and bootstraps **FluxCD** for GitOps delivery.  
It supports a **local Kind** cluster for testing and a **GKE** cluster for production-like deployment.  
The application example is **kbot**, deployed via Flux `GitRepository` + `HelmRelease`. Secrets are delivered GitOps-safe via **SOPS + age**.

## Repos
- **Infrastructure (this repo):** Terraform modules for Kind/GKE + Flux bootstrap
- **GitOps repo:** `flux-gitops` (cluster manifests under `clusters/<env>/...`)
- **App repo:** `kbot` (Helm chart + GitHub Actions builds/pushes image & updates chart)

## Prerequisites
- Terraform, kubectl, flux CLI, sops, age
- GCP project with billing (for GKE)
- GitHub token (repo access) and GHCR access if images are private
- `age.agekey` (private key) available locally (do **not** commit)

## Quick start (Kind)

Uncomment kind module section in `main.tf` and modify `config_path` variable in `flux_bootstrap` module if needed.
```bash
terraform workspace new kind || terraform workspace select kind
terraform init
terraform apply

flux check
```

## Deploy to GKE
```bash
terraform workspace new gke || terraform workspace select gke
terraform init
terraform apply

kubectl get nodes
flux check
```

## Secrets (SOPS + age)
1. Encrypt secrets in flux-gitops as *.sops.yaml
2. Create the decryption key in the target cluster:
```bash
kubectl -n flux-system create secret generic sops-age \
  --from-file=age.agekey=./age.agekey
```
3. Make `age.agekey` available locally for decrypting/editing:
```bash
export SOPS_AGE_KEY_FILE="$PWD/age.agekey"
sops -d clusters/gke/kbot/telegram-token-secret.sops.yaml | head -n 80
```

## Validation
```bash
flux get all -A
kubectl -n kbot get pods
kubectl -n kbot logs -l app.kubernetes.io/instance=kbot --tail=50
```

## What not to commit
- `age.agekey`, kubeconfig files, Terraform state, plaintext secrets