#!/usr/bin/env bash

## balena-cli install script
## Sam Dennon // 2022

VERSION=v14.5.2

# Set the CLI version
echo "INstalling balena-cli"
BALENA_CLI_VERSION="${BALENA_CLI_VERSION:-${VERSION}}"
sudo -s -- <<EOF
mkdir -p /usr/local/share/balena-cli
wget -qO /usr/local/share/balena-cli.zip \
"https://github.com/balena-io/balena-cli/releases/download/${BALENA_CLI_VERSION}/balena-cli-${BALENA_CLI_VERSION}-linux-x64-standalone.zip"
unzip -qq -o /usr/local/share/balena-cli.zip -d /usr/local/share/
rm /usr/local/share/balena-cli.zip
if [[ -L "/usr/bin/balena" ]]
  then
    if [[ -e "/usr/bin/balena" ]]
      then
        echo "balena-cli is linked"
    else
      echo "rebuilding balena-cli link"
      unlink /usr/bin/balena
      ln -s /usr/local/share/balena-cli/balena /usr/bin/balena
    fi
else
  echo "linking balena-cli"
  ln -s /usr/local/share/balena-cli/balena /usr/bin/balena
fi
echo "balena-cli installed"
balena -h
EOF
