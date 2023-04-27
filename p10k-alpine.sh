#!/usr/bin/env ash

## P10k Install Script (for Alpine)
## Sam Dennon // 2022
## Updated: 27APR2023
## Translation by ChatGPT # LOL ##

## root or sudo check
if [[ $EUID -eq 0 ]]; then
    echo "You have permission to run this script as root."
else
    if groups $USER | grep -q sudo; then
        echo "You have permission to run this script with sudo."
    else
        echo "You do not have permission to run this script. Get some sudo and try again!"
        exit 1337
    fi
fi

## Get some infos
echo "We need to collect some info from you."
read -p 'Github username: ' GH_USERNAME
read -p 'Github email address: ' GH_EMAIL
read -p 'What name do you want to use for the default branch in git repos? ' GH_DEFAULT
read -p 'Your username on this system: ' USER
echo " "
echo "Is this info correct?"
echo " "
echo "Github username: $GH_USERNAME"
echo "Github email address: $GH_EMAIL"
echo "git default branch name: $GH_DEFAULT"
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

## TODO ask if this will be a Desktop or Server install
function check_nerd_font() {
    if fc-list | grep -q "Operator Mono Lig Book NF.otf"
      then
        echo "Setting Gnome monospace font to Operator Mono Nerd Font"
        gsettings set org.gnome.desktop.interface monospace-font-name 'SauceCodePro Nerd Font Mono Regular 14'
      else
        echo 'Nerd fonts not installed. Please run `sh -c "$(wget -O- https://bit.ly/NerdFonts)"` to install.'
        exit 1
    fi
}

echo "Wird dies ein Gnome-Desktop oder ein Server sein?"
echo "Desktop-Installationen erfordern zuerst die Installation eines Nerds."
read -p "(1) Server : (2) Desktop" INSTALL_TYPE

case $INSTALL_TYPE in
    1 | Server | server | 1337)
        echo "Cool! Es wird ein Server sein!";;
    2 | Desktop | desktop | gnome | noob)
        echo "Desktop! Gnome ist das Beste!"
        check_nerd_font();;
    *)
        echo "Ich bin mir nicht sicher, was Sie wollen ... Versuchen Sie es erneut? (I'm not sure what you want... try again?)"
        exit 1;;
esac
     

## TODO Add some OS Distro checking stuff...

sudo chsh -s /bin/zsh $USER

git config --global user.name $GH_USERNAME
git config --global user.email $GH_EMAIL
git config --global init.defaultBranch $GH_DEFAULT
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/.zsh/powerlevel10k
git clone https://github.com/zsh-users/zsh-autosuggestions ~/.zsh/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.zsh/zsh-syntax-highlighting
cat << EOF >> ~/.zshrc
source ~/.zsh/powerlevel10k/powerlevel10k.zsh-theme
source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
source ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt appendhistory
alias ls="ls --color=auto"
alias lsa="ls -al --color=auto"
neofetch
EOF
exec zsh
