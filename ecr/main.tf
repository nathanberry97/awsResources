terraform {
  backend "s3" {
    bucket = "s3-backend-nathan"
    key    = "ecr/repos/terraform.tfstate"
    region = "eu-west-2"
  }
}

locals {
  repo = var.REPO_NAME
}

# Create ecr repo
resource "aws_ecr_repository" "ecr_repo" {
  name = "${local.repo}"
}
