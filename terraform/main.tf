locals {
  accountId = var.ACCOUNT_ID
}

module "admin_user" {
  source     = "./modules/adminUser"
}

module "pipeline_user" {
  source     = "./modules/pipelineUser"
  ACCOUNT_ID = local.accountId
}

module "ecr_repos" {
  source     = "./modules/ecr"
  ACCOUNT_ID = local.accountId
}
