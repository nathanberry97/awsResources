# AWS resources

This repo is intend to store AWS resources I use within my personal account and
don't belong to anyone repo.

## mfa

This folder containers the mfa script I use for my CLI user this is to ensure
that you need to use mfa before using any CLI commands.

| content         | overview                                           |
|-----------------|----------------------------------------------------|
| mfa.sh          | shell script to automate enabling mfa within shell |
| mfaEnable.json  | policy to enforce mfa for AWS cli                  |
| credentials.swp | swap file which is used as reference in mfa.sh     |

To use this script it is recommended to store the mfa.sh in the following
directory:

- `~/.local/bin/`

## pipelineUser

This folder stores the terraform code to create a user which is needed for my
pipeline builds which use the `aws cdk`.

Once the user has been created you will need to add the access key and secret
key into your pipeline secret vars.

| content      | overview                                        |
|--------------|-------------------------------------------------|
| main.tf      | Stores the IaC which sets up the config in AWS  |
| variables.tf | Where you declare the variables for terraform   |
| output.tf    | Outputs the access key for pipeline user        |
| providers.tf | The providers which are used in the deployment  |
