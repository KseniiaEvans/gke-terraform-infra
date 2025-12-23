variable "GOOGLE_PROJECT" {
  type        = string
  description = "GCP project id/name"
}

variable "GOOGLE_REGION" {
  type        = string
  description = "GCP region or zone (for your module it's used as cluster location too)"
}

variable "GKE_NUM_NODES" {
  type        = number
  default     = 1
  description = "GKE nodes count"
}

variable "GITHUB_OWNER" {
  type        = string
  description = "GitHub org/user"
}

variable "GITHUB_TOKEN" {
  type        = string
  description = "GitHub PAT with repo scope"
  sensitive   = true
}

variable "FLUX_GITOPS_REPO" {
  type        = string
  default     = "flux-gitops"
  description = "Name of GitOps repo to be created/used by Flux"
}

variable "DELETION_PROTECTION" {
  type        = bool
  default     = true
  description = "Enable GKE deletion protection"
}
