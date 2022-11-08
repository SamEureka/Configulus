#!/usr/bin/env bash

## balena-cli install script
## Sam Dennon // 2022

# Set the CLI version
echo "INstalling balena-cli"
BALENA_CLI_VERSION="${BALENA_CLI_VERSION:-v14.3.1}"
sudo -s -- <<EOF
mkdir -p /usr/local/share/balena-cli
wget -qO /usr/local/share/balena-cli.zip \
"https://github.com/balena-io/balena-cli/releases/download/${BALENA_CLI_VERSION}/balena-cli-${BALENA_CLI_VERSION}-linux-x64-standalone.zip"
unzip -qq -o /usr/local/share/balena-cli.zip -d /usr/local/share/
rm /usr/local/share/balena-cli.zip
ln -s /usr/local/share/balena-cli/balena /usr/bin/balena
echo "balena-cli installed"
EOF
