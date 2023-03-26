# Pipeline user for CDK bootstrap

This IaC written in terraform is to create a user to be used with a pipeline and
allow this user to assume into roles created by `aws cdk` bootstrap process.

## Prerequisite

You need to ensure you have the following environment variable:

- `export TF_VAR_ACCOUNT_ID=ACCOUNT_NUMBER`

## Steps to build and deploy the IaC

Once you have cloned the repo you first need to run the following command:

- `terraform init`

After the command has been ran you can run the nest command to deploy the code:

- `terraform apply`

Once the deployment has completed this would have created a new user called
`cdkPipelineUser`, to confirm this you can run the following command:

```shell
aws iam list-users --query Users[*].UserName | grep cdkPipelineUser
```

## Retrieving users secret

Once the user has been created you'll be able to access the secret key value
by running the following command:

```shell
aws ssm get-parameter \
  --name pipelineSecretKey --region eu-west-2 \
  --with-decryption --query Parameter.Value \
  | awk -F {print $2}
```

> **Note** ensure you keep this value a secret as it is the equivalent of a password

# Other useful commands

- `terraform validate`
- `terraform plan`
- `terraform destroy`
