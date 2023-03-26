# AWS resources

This repo is intend to store AWS resources I use within my personal account and
don't belong to anyone repo.

## mfa

This folder containers the mfa script I use for my CLI user this is to ensure
that you need to use mfa before using any CLI commands.

| content        | overview                                           |
|----------------|----------------------------------------------------|
| mfa.sh         | shell script to automate enabling mfa within shell |
| mfaEnable.json | policy to enforce mfa for AWS cli                  |

To use this script it is recommended to store the mfa.sh in the following
directory:

- `~/.local/bin/`
