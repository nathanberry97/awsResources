locals {
  repo    = var.REPO_NAME
}

# Create ecr repo
resource "aws_ecr_repository" "ecr_repo" {
  name = "${local.repo}"
}
