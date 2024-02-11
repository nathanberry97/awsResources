#!/bin/bash

TOKEN=$1
MFA_ARN='arn:aws:iam::accountNum:mfa/user'

CRED=$(
  aws sts get-session-token \
    --serial-number $MFA_ARN \
    --token-code $TOKEN \
    --profile default \
    --output text
)

ACCESS_KEY=$(echo $CRED | awk '{print $2}')
SECRET_ACCESS_KEY=$(echo $CRED | awk '{print $4}')
SESSION_TOKEN=$(echo $CRED | awk '{print $5}')

cp ~/.aws/credentials.swp ~/.aws/credentials

echo "[mfa]" >> ~/.aws/credentials
echo "aws_access_key_id = ${ACCESS_KEY}" >> ~/.aws/credentials
echo "aws_secret_access_key = ${SECRET_ACCESS_KEY}" >> ~/.aws/credentials
echo "aws_session_token = ${SESSION_TOKEN}" >> ~/.aws/credentials
