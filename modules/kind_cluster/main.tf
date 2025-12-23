resource "null_resource" "kind_create" {
  triggers = {
    cluster_name   = var.cluster_name
    kubeconfig     = var.kubeconfig_path
    kind_image     = var.kind_image
  }

  provisioner "local-exec" {
    command = <<EOT
set -euo pipefail
mkdir -p "$(dirname "${var.kubeconfig_path}")"

kind get clusters | grep -q "^${var.cluster_name}$" || kind create cluster --name "${var.cluster_name}" --image "${var.kind_image}"
kind get kubeconfig --name "${var.cluster_name}" > "${var.kubeconfig_path}"
EOT
    interpreter = ["/bin/bash", "-c"]
  }

  provisioner "local-exec" {
    when    = destroy
    command = var.delete_on_destroy ? "kind delete cluster --name \"${self.triggers.cluster_name}\" || true" : "true"
    interpreter = ["/bin/bash", "-c"]
  }
}
