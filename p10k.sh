#!/usr/bin/env bash

## P10k Install Script
## Sam Dennon // 2022

echo "We need to collect some info from you."
read -p 'Github username: ' GH_USERNAME
read -p 'Github email address: ' GH_EMAIL
read -p 'Your username on this system: ' USER

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
