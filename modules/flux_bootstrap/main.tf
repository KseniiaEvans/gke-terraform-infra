provider "flux" {
  kubernetes = {
    config_path = var.kubeconfig_path
  }

  git = {
    url = "ssh://${var.git_ssh_username}@github.com/${var.github_repository}.git"

    ssh = {
      username    = var.git_ssh_username
      private_key = var.git_ssh_private_key_pem
    }
  }
}

resource "flux_bootstrap_git" "this" {
  path    = var.target_path
  branch  = var.branch

  # щоб не “висіло” занадто довго на першому apply
  interval = var.interval
}
