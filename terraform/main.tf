locals {
  accountId = var.ACCOUNT_ID
}

module "admin_user" {
  source = "./modules/adminUser"
}

module "pipeline_user" {
  source     = "./modules/pipelineUser"
  ACCOUNT_ID = local.accountId
}
