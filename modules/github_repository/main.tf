provider "github" {
  owner = var.github_owner
  token = var.github_token
}

resource "github_repository" "this" {
  name        = var.repository_name
  visibility  = var.repository_visibility
  auto_init   = true
  has_issues  = false
  has_wiki    = false
  has_projects = false
}

resource "github_branch_default" "default" {
  repository = github_repository.this.name
  branch     = var.branch
}

resource "github_repository_deploy_key" "flux" {
  repository = github_repository.this.name
  title      = var.public_key_openssh_title
  key        = var.public_key_openssh
  read_only  = false
}
