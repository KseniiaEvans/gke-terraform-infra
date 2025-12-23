variable "github_owner" {
  type        = string
  description = "GitHub org/user"
}

variable "github_token" {
  type        = string
  description = "GitHub PAT"
  sensitive   = true
}

variable "repository_name" {
  type        = string
  description = "Repo name"
}

variable "repository_visibility" {
  type        = string
  default     = "private"
  description = "private/public"
}

variable "branch" {
  type        = string
  default     = "main"
}

variable "public_key_openssh" {
  type        = string
  description = "Public key for deploy key"
}

variable "public_key_openssh_title" {
  type        = string
  default     = "flux"
}
