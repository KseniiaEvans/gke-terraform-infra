variable "cluster_name" {
  type        = string
  default     = "dev"
  description = "kind cluster name"
}

variable "kubeconfig_path" {
  type        = string
  default     = ".kube/kind-kubeconfig"
  description = "Where to write kubeconfig for kind cluster"
}

variable "kind_image" {
  type        = string
  default     = "kindest/node:v1.29.2"
  description = "kind node image"
}

variable "delete_on_destroy" {
  type        = bool
  default     = true
}
