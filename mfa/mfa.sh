#!/bin/bash

TOKEN=$1
MFA_ARN=''

CRED=$(aws sts get-session-token \
  --serial-number $MFA_ARN \
  --token-code $TOKEN \
  --profile default \
  --output text)

ACCESS_KEY=$(echo $CRED | awk '{print $2}')
SECRET_ACCESS_KEY=$(echo $CRED | awk '{print $4}')
SESSION_TOKEN=$(echo $CRED | awk '{print $5}')

cp ~/.aws_backup/credentials ~/.aws/credentials 

echo '[mfa]' \
  '\naws_access_key_id = '$ACCESS_KEY \
  '\naws_secret_access_key = '$SECRET_ACCESS_KEY \
  '\naws_session_token = '$SESSION_TOKEN \
  >> ~/.aws/credentials
