# Scripts

## mfa.sh

This script allows me to easily setup mfa in my terminal environment, to give
another level of security before you are able to start using any cli commands.

First you need to create the following policy and attach to the user you want to
use mfa:

```json
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "BlockMostAccessUnlessSignedInWithMFA",
            "Effect": "Deny",
            "NotAction": [
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
            ],
            "Resource": "*",
            "Condition": {
                "BoolIfExists": {
                    "aws:MultiFactorAuthPresent": "false"
                }
            }
        }
    ]
}
```

> I have this policy defined in my terraform config within the user module

Now you won't be able to use any cli commands until to set up your mfa credentials.

To do this you will need to use the following scrip `./mfa.sh`, now edit line 4
and add your users mfa arn.

Once added run the following command:

```shell
cp ./mfa.sh ~/.local/bin/mfa
```

Now we need to add the `./credentials.swp` to your `~/.aws/` directory, once added
ensure you add your key and secret key.

Lastly you will need to run the following command:

```shell
echo "export AWS_PROFILE=mfa" >> ~/.bashrc
source ~/.bashrc
```

Finally you are able to use the AWS cli once you enter the following:

```shell
mfa TOKEN
```

> **Note** replace `TOKEN` with mfa token
