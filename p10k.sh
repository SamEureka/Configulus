#!/usr/bin/env bash

## P10k Install Script
## Sam Dennon // 2022

echo "We need to collect some info from you."
read -p 'Github username: ' GH_USERNAME
read -p 'Github email address: ' GH_EMAIL
read -p 'Your username on this system: ' USER
echo " "
echo "Is this info correct?"
echo " "
echo "Github username: $GH_USERNAME"
echo "Github email address: $GH_EMAIL"
echo "System username: $USER"
read -p '(y)es / (n)o: ' ANSWER

case $ANSWER in
  y | yes | Y | YES | 1 | Yes)
    echo "Cool! Let's do this!";;
  n | no | N | NO | 0 | No)
    echo "Exiting, try running the script again."
    exit 1;;    
  *)
    echo "Answer not understood, try 'y' or 'n'. exiting."
    exit 1;;
esac

if fc-list | grep -q "Operator Mono Lig Book NF.otf"
  then
    echo "Setting Gnome monospace font to Operator Mono Nerd Font"
    gsettings set org.gnome.desktop.interface monospace-font-name 'SauceCodePro Nerd Font Mono Regular 14'
  else
    echo 'Nerd fonts not installed. Please run `sh -c "$(wget -O- https://bit.ly/NerdFonts)"` to install.'
    exit 1
fi

sudo chsh -s /usr/bin/zsh $USER

git config --global user.name $GH_USERNAME
git config --global user.email $GH_EMAIL
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/.zsh/powerlevel10k
git clone https://github.com/zsh-users/zsh-autosuggestions ~/.zsh/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.zsh/zsh-syntax-highlighting
cat << EOF >> ~/.zshrc
source ~/.zsh/powerlevel10k/powerlevel10k.zsh-theme
source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
source ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
EOF
exec zsh
