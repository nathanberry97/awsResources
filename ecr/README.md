# ECR repo

This IaC written in terraform is to create a ecr repo to be used for container
projects.

## Prerequisite

You need to ensure you have the following environment variable:

- `export TF_VAR_ACCOUNT_ID=ACCOUNT_NUMBER`

## Steps to build and deploy the IaC

Once you have cloned the repo you first need to run the following command:

- `terraform init`

After the command has been ran you can run the nest command to deploy the code:

- `terraform apply`

## Other useful commands

- `terraform validate`
- `terraform plan`
- `terraform destroy`
