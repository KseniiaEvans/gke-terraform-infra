output "repository_name" {
  value = github_repository.this.name
}

output "clone_http_url" {
  value = github_repository.this.http_clone_url
}

output "clone_ssh_url" {
  value = github_repository.this.ssh_clone_url
}
