variable "REPO_NAME" {
  description = "The name of the ecr repo"
  type = string
  default = "nasa_apod"
}

variable "ACCOUNT_ID" {
  description = "AWS account id"
  type = string
}
