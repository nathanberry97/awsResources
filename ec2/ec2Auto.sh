#!/bin/bash

INSTANCE_ID=""
KEY_PATH=""

connect() {
  PUBLIC_DNS=$(
    aws ec2 describe-instances \
      --region eu-west-2 \
      --instance-ids ${INSTANCE_ID} \
      | grep PublicDnsName \
      | awk '{print $2}' \
      | awk -F \" '{print $2}' \
      | tail -n 1
  )

  ssh -i ${KEY_PATH} ec2-user@${PUBLIC_DNS}
}

run_ec2() {
  aws ec2 start-instances \
    --instance-ids ${INSTANCE_ID} \
    --region eu-west-2 \
    --output text
}


stop_ec2() {
  aws ec2 stop-instances \
    --instance-ids ${INSTANCE_ID} \
    --region eu-west-2 \
    --output text
}

auto_help() {
  echo -e "AutoInstance\n"
  echo -e "usage: ag [argument]\n"
  echo "Arguments:"
  echo "  -c        connect to ec2 instance"
  echo "  -r        run ec2 instance"
  echo "  -s        stop ec2 instance"
  echo "  -h        help menu"
  exit 0
}

invalid_option() {
  echo "Invalid option: -$OPTARG"
  exit 1
}

argument_needed() {
  echo "Option -$OPTARG requires an argument."
  exit 1
}

while getopts ":h?r?c?s?" opt; do
  case $opt in
    r)
      run_ec2;;
    c)
      connect;;
    s)
      stop_ec2;;
    h)
      auto_help;;
    \?)
      invalid_option;;
    :)
      argument_needed;;
  esac
done

aws ec2 describe-instances \
  --region eu-west-2 \
  --instance-ids ${INSTANCE_ID}
