module "github_repository" {
  source                   = "./modules/github-repository"
  github_owner             = var.GITHUB_OWNER
  github_token             = var.GITHUB_TOKEN
  repository_name          = var.FLUX_GITHUB_REPO
  public_key_openssh       = module.tls_private_key.public_key_openssh
  public_key_openssh_title = "flux0"
}

module "gke_cluster" {
  source              = "./modules/google-gke-cluster"
  GOOGLE_REGION       = var.GOOGLE_REGION
  GOOGLE_PROJECT      = var.GOOGLE_PROJECT
  GKE_NUM_NODES       = var.GKE_NUM_NODES
  DELETION_PROTECTION = var.DELETION_PROTECTION
}

# module "kind_cluster" {
#   source = "./modules/kind-cluster"
# }

module "tls_private_key" {
  source    = "./modules/hashicorp-tls-keys"
  algorithm = "RSA"
}

module "flux_bootstrap" {
  source            = "./modules/fluxcd-flux-bootstrap"
  github_repository = "${var.GITHUB_OWNER}/${var.FLUX_GITHUB_REPO}"
  github_token      = var.GITHUB_TOKEN
  private_key       = module.tls_private_key.private_key_pem
  # config_path       = module.kind_cluster.kubeconfig_path
  config_path = local.kubeconfig_path
  target_path = var.FLUX_GITHUB_TARGET_PATH
}
