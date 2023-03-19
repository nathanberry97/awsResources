# AWS resources

This repo is intend to store resources I use within my AWS account

## mfa

| content        | overview                                           |
|----------------|----------------------------------------------------|
| mfa.sh         | shell script to automate enabling mfa within shell |
| mfaEnable.json | policy to enforce mfa for AWS cli                  |

To use this script it is recommended to store the mfa.sh in the following
directory:

- `~/.local/bin/`
