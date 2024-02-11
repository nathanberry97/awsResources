output "ecr_repo_urls" {
  value = [for repo in aws_ecr_repository.ecr_repo : repo.repository_url]
}
