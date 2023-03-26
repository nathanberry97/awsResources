locals {
  user    = var.USER_NAME
  account = var.ACCOUNT_ID
}

# Create cdk pipeline user
resource "aws_iam_user" "cdk_pipeline" {
  name = "${local.user}"
}

# Create iam user policy to assume cdk roles
resource "aws_iam_user_policy" "assume_role" {
  name   = "cdkPipelineUser"
  user   = aws_iam_user.cdk_pipeline.name
  policy = jsonencode({
    Version   = "2012-10-17"
    Statement = [
      {
        Action   = [ "sts:AssumeRole"]
        Effect   = "Allow"
        Resource = "arn:aws:iam::${local.account}:role/cdk-*"
      },
    ]
  })
}

# Create access key for user
resource "aws_iam_access_key" "pipeline_creds" {
  user = aws_iam_user.cdk_pipeline.name
}

# Store access key in SSM parameter secret string
resource "aws_ssm_parameter" "pipeline_secret" {
  name = "pipelineSecretKey"
  type = "SecureString"
  value = aws_iam_access_key.pipeline_creds.secret
}
