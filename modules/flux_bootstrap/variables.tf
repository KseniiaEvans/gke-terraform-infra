variable "github_token" {
  type        = string
  description = "GitHub PAT used by flux provider (for Git operations/commits)"
  sensitive   = true
}

variable "github_repository" {
  type        = string
  description = "owner/repo"
}

variable "kubeconfig_path" {
  type        = string
  description = "Path to kubeconfig"
}

variable "target_path" {
  type        = string
  default     = "clusters/dev"
  description = "Path in Git repo where Flux manifests will be committed"
}

variable "git_ssh_private_key_pem" {
  type        = string
  description = "SSH private key (PEM) for repo deploy key"
  sensitive   = true
}

variable "git_ssh_username" {
  type        = string
  default     = "git"
}

variable "branch" {
  type        = string
  default     = "main"
}

variable "interval" {
  type        = string
  default     = "1m"
}
