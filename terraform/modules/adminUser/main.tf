locals {
  group_name = var.GROUP_NAME
  user_name  = var.USER_NAME
}

resource "aws_iam_group" "admin" {
  name = local.group_name
}

resource "aws_iam_user_group_membership" "attach_group_to_user" {
  user   = local.user_name
  groups = [ aws_iam_group.admin.name ]
}

resource "aws_iam_group_policy_attachment" "attach_admin_access" {
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
  group      = aws_iam_group.admin.name
}

resource "aws_iam_group_policy" "mfa_cli_enable" {
  name    = "mfaCliEnable"
  group   = aws_iam_group.admin.name
  policy  = jsonencode({
    Version   = "2012-10-17"
    Statement = [{
      Sid       = "BlockMostAccessUnlessSignedInWithMFA",
      Effect    = "Deny",
      Resource  = "*",
      Condition = { BoolIfExists = { "aws:MultiFactorAuthPresent": "false" } },
      NotAction = [
        "iam:CreateVirtualMFADevice",
        "iam:DeleteVirtualMFADevice",
        "iam:ListVirtualMFADevices",
        "iam:EnableMFADevice",
        "iam:ResyncMFADevice",
        "iam:ListAccountAliases",
        "iam:ListUsers",
        "iam:ListSSHPublicKeys",
        "iam:ListAccessKeys",
        "iam:ListServiceSpecificCredentials",
        "iam:ListMFADevices",
        "iam:GetAccountSummary",
        "sts:GetSessionToken"
      ]
    }]
  })
}
