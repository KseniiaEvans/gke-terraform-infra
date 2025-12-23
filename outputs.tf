output "gke_kubeconfig_path" {
  value = module.gke_cluster.kubeconfig
}

output "gitops_repo" {
  value = "${var.GITHUB_OWNER}/${module.gitops_repo.repository_name}"
}
