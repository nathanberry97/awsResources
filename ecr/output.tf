# Output access key
output "repo_arn" {
  value = aws_ecr_repository.ecr_repo.arn
}
output "repo_name" {
  value = aws_ecr_repository.ecr_repo.name
}
output "name" {
  value = aws_ecr_repository.ecr_repo.repository_url
}
