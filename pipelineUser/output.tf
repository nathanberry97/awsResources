# Output access key
output "access_key" {
  value = aws_iam_access_key.pipeline_creds.id
}
