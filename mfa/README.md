# mfa

This directory allows me to easily setup mfa in my terminal environment, to give
another level of security before you are able to start using any cli commands.

First you need to create the policy and attach to the user you want to use mfa,
there is a policy document `./mfaEnable.json` you can use to achieve this.

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
