# ec2 cli commands

download keypair:

```console
aws ssm get-parameter \
  --name /ec2/keypair/key-id \
  -- region eu-west-2 \
  --with-decryption \
  --output text \
  > linuxSeverKeyPair.pem
```

update keypair permissions:

```console
chmod 400 key.pem
```

ssh into ec2 instance:

```console
ssh -i "key.pem" \
  ec2-user@public_dns
```

start ec2 instance:

```console
aws ec2 start-instances \
  --instance-ids instance_id \
  --region eu-west-2
```

stop ec2 instance:

```console
aws ec2 stop-instances \
  --instance-ids instance_id \
  --region eu-west-2
```

