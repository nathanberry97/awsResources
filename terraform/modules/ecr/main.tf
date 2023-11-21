locals {
  apod_sms = "nasa_apod"
  apod_html = "nasa_apod_html"
}

resource "aws_ecr_repository" "ecr_repo_apod" {
  name = local.apod_sms
}

resource "aws_ecr_repository" "ecr_repo_apod_html" {
  name = local.apod_html
}
