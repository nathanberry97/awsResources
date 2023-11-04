locals {
  user    = var.USER_NAME
  account = var.ACCOUNT_ID
}

resource "aws_iam_user" "cdk_pipeline" {
  name = local.user
}

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

resource "aws_iam_access_key" "pipeline_creds" {
  user = aws_iam_user.cdk_pipeline.name
}

resource "aws_ssm_parameter" "pipeline_secret" {
  name = "pipelineSecretKey"
  type = "SecureString"
  value = aws_iam_access_key.pipeline_creds.secret
}
