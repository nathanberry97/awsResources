output "admin_group_name" {
  value = module.admin_user.admin_access_group
}

output "admin_access_key" {
  value = module.pipeline_user.access_key
}
