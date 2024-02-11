# AWS resources

![linting](https://github.com/nathanberry97/awsResources/actions/workflows/lintingPipeline.yaml/badge.svg)

> This repo is intend to store AWS resources I use within my personal AWS

## CloudFormation

This folder creates a S3 bucket intended to be used as the backend for any
terraform projects I do within my AWS account.

To deploy the CloudFormation stack you can run the following command:

```shell
make deploy
```

## Terraform

> This IaC written in terraform is to create the following:
>
> -   user to be used for pipeline deployments
> -   creates ECR repos
> -   Admin access to imported users and enforces MFA

### Prerequisite

You need to ensure you have the following environment variable:

-   `export TF_VAR_ACCOUNT_ID=ACCOUNT_NUMBER`

### Steps to build and deploy the IaC

Once you have cloned the repo you first need to run the following command:

-   `make init`

After the command has been ran you can run the nest command to deploy the code:

-   `make apply`

Once the deployment has completed this would have created a new user called
`cdkPipelineUser`, to confirm this you can run the following command:

```shell
aws iam list-users --query Users[*].UserName | grep cdkPipelineUser
```

### Retrieving users secret

Once the user has been created you'll be able to access the secret key value
by running the following command:

```shell
aws ssm get-parameter \
  --name pipelineSecretKey --region eu-west-2 \
  --with-decryption --query Parameter.Value \
  | awk -F {print $2}
```

> **Note** ensure you keep this value a secret as it is the equivalent of a password

## Scripts

This folder containers the mfa script I use for my CLI user this is to ensure
that you need to use mfa before using any CLI commands.

| content         | overview                                           |
| --------------- | -------------------------------------------------- |
| mfa.sh          | shell script to automate enabling mfa within shell |
| credentials.swp | swap file which is used as reference in mfa.sh     |

To use this script it is recommended to store the mfa.sh in the following
directory:

-   `~/.local/bin/`

And store credentials.swp in the following directory:

-   `~/.aws/credentials.swp`

### mfa.sh

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
