'#!/usr/bin/env bash

## NerdFont install script
## Sam Dennon // 2022

if [ -d /usr/share/fonts/nerd/ ]
  then
    echo "NerdFonts already installed, exiting."
    exit 1
  else
    echo "INstalling NerdFonts (sudo required)"
fi

sudo -s -- <<EOF
mkdir -p /usr/share/fonts/nerd
echo "Downloading Font zip one."
wget -qO /usr/share/fonts/nerd/NF1.zip "http://bit.ly/3DVVyLx"
echo "Downloading Font zip two."
wget -qO /usr/share/fonts/nerd/NF2.zip "http://bit.ly/3A2uqtf"
echo "Downloading Font zip three."
wget -qO /usr/share/fonts/nerd/NF3.zip "http://bit.ly/3fOowVM"
echo "Downloading Font zip four."
wget -qO /usr/share/fonts/nerd/NF4.zip "http://bit.ly/3TlMk11"
echo "Downloading Font zip five."
wget -qO /usr/share/fonts/nerd/NF5.zip "http://bit.ly/3GabpsC"
echo "un-zzzzzzzzzzzzzzzzzip"
unzip -qj "/usr/share/fonts/nerd/*.zip" -d /usr/share/fonts/nerd
rm /usr/share/fonts/nerd/*.zip
echo "Rebuilding the font cache."
fc-cache -f -v > /dev/null 2>&1
echo "NerdFonts installed"
EOF
