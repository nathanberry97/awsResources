locals {
  repo = var.REPO_NAME
}

resource "aws_ecr_repository" "ecr_repo_apod" {
  name = local.repo
}
