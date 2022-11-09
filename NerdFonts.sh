#!/usr/bin/env bash

## NerdFont install script
## Sam Dennon // 2022

echo "INstalling NerdFonts (sudo required)"

sudo -s -- <<EOF
mkdir -p /usr/share/fonts/nerd
wget -qO /usr/share/fonts/nerd/NF1.zip "http://bit.ly/3DVVyLx" 
wget -qO /usr/share/fonts/nerd/NF2.zip "http://bit.ly/3A2uqtf"
wget -qO /usr/share/fonts/nerd/NF3.zip "http://bit.ly/3fOowVM"
wget -qO /usr/share/fonts/nerd/NF4.zip "http://bit.ly/3TlMk11"
wget -qO /usr/share/fonts/nerd/NF5.zip "http://bit.ly/3GabpsC"
unzip -qj "/usr/share/fonts/nerd/*.zip" -d /usr/share/fonts/nerd
rm /usr/share/fonts/nerd/*.zip
fc-cache -f -v
echo "NerdFonts installed"
EOF
