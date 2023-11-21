output "sms_url" {
  value = aws_ecr_repository.ecr_repo_apod.repository_url
}

output "html_url" {
  value = aws_ecr_repository.ecr_repo_apod_html.repository_url
}
