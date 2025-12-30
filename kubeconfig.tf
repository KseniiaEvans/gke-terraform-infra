terraform {
  required_providers {
    local = {
      source  = "hashicorp/local"
      version = "~> 2.0"
    }
  }
}

resource "local_file" "gke_kubeconfig" {
  filename        = "${path.module}/.kubeconfig-gke"
  file_permission = "0600"
  content         = module.gke_cluster.kubeconfig_raw
}

locals {
  kubeconfig_path = local_file.gke_kubeconfig.filename
}

provider "kubernetes" {
  config_path = local.kubeconfig_path
}
