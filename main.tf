terraform {
  backend "gcs" {
    bucket = "tf-state-gke-kseniia"
    prefix = "terraform/state"
  }
}

module "gke_cluster" {
  source              = "github.com/KseniiaEvans/tf-google-gke-cluster"
  GOOGLE_REGION       = var.GOOGLE_REGION
  GOOGLE_PROJECT      = var.GOOGLE_PROJECT
  GKE_NUM_NODES       = var.GKE_NUM_NODES
  DELETION_PROTECTION = false
}

module "tls_keys" {
  source = "./modules/tls_keys"
}

module "gitops_repo" {
  source                   = "./modules/github_repository"
  github_owner             = var.GITHUB_OWNER
  github_token             = var.GITHUB_TOKEN
  repository_name          = var.FLUX_GITOPS_REPO
  repository_visibility    = "private"
  branch                   = "main"
  public_key_openssh       = module.tls_keys.public_key_openssh
  public_key_openssh_title = "flux"
}

module "flux_bootstrap" {
  source           = "./modules/flux_bootstrap"
  github_token     = var.GITHUB_TOKEN
  github_repository = "${var.GITHUB_OWNER}/${module.gitops_repo.repository_name}"

  # Flux підключається по SSH (deploy key у repo)
  git_ssh_private_key_pem = module.tls_keys.private_key_pem
  git_ssh_username        = "git"

  # kubeconfig з твого gke module auth
  kubeconfig_path = module.gke_cluster.kubeconfig

  # куди комітити flux manifests у GitOps repo:
  target_path = "clusters/gke"
}
