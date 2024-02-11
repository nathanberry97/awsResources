# AWS resources

> This repo is intend to store AWS resources I use within my personal AWS
> account all written in IaC

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

## Terraform

This folder stores the terraform code to create a user which is needed for my
pipeline builds which use the `aws cdk`.

Also creates ECR repos and Admin access with MFA needing to be enabled through
the Command Line.

## CloudFormation

This folder creates a S3 bucket intended to be used as the backend for any
terraform projects I do within my AWS account.
