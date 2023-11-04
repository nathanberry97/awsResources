variable "USER_NAME" {
  description = "The name of the pipeline user"
  type = string
  default = "CdkPipelineUser"
}

variable "ACCOUNT_ID" {
  description = "AWS account id"
  type = string
}
