#!/bin/ash

## P10k Install Script (for Alpine)
## Sam Dennon // 2022
## Updated: 27APR2023
## German translations by ChatGPT # LOL ##

TIMEOUT_COUNT=0

## root or sudo check
root_sudo_check() {
    if [ "$(id -u)" -eq 0 ]; then
        echo "You have permission to run this script as root."
    else
        if groups $USER | grep -q sudo; then
            echo "You have permission to run this script with sudo."
        else
            echo "You do not have permission to run this script. Get some sudo and try again!"
            exit 1337
        fi
    fi
}

install_bash() {
    apk add bash
    let "TIMEOUT_COUNT++"
    check_and_install_you_some_bash
}

check_and_install_you_some_bash(){
    if test -f /bin/bash; then
        echo "We have positive bashage!"
        TIMEOUT_COUNT=0
    else
        echo "get you some bash!"
        if let "TIMEOUT_COUNT < 3"; then
            echo "let there be bash!"
            install_bash
        else
            echo "We tried a few times.... no bash for you."
        fi
    fi
}


# Check for permissions first... 
root_sudo_check

# Install you some bash
check_and_install_you_some_bash

## Get some Github infos
get_github_info() {
    echo "We need to collect some info from you."
    read -p 'Github username: ' GH_USERNAME
    read -p 'Github email address: ' GH_EMAIL
    read -p 'What name do you want to use for the default branch in git repos? ' GH_DEFAULT
    echo " "
    echo "Is this info correct?"
    echo " "
    echo "Github username: $GH_USERNAME"
    echo "Github email address: $GH_EMAIL"
    echo "git default branch name: $GH_DEFAULT"
    echo " "
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
}

## ~~TODO ask if this will be a Desktop or Server install~~
check_nerd_font() {
    if fc-list | grep -q "Operator Mono Lig Book NF.otf"; then
        echo "Setting Gnome monospace font to Operator Mono Nerd Font"
        gsettings set org.gnome.desktop.interface monospace-font-name 'SauceCodePro Nerd Font Mono Regular 14'
      else
        echo 'Nerd fonts not installed. Please run `sh -c "$(wget -O- https://bit.ly/NerdFonts)"` to install.'
        exit 1
    fi
}


## TODO Add some OS Distro checking stuff...

check_installed_packages (){
    # Get the community repositoria going
    sed -i '/^#http:\/\/dl-cdn.alpinelinux.org\/alpine\/v.*\/community/s/^#//' /etc/apk/repositories
    apk update -q
    # remove any installed packages from the package list
    INSTALLED_PACKAGES=$(apk info -e $PACKAGES)
    for package in $INSTALLED_PACKAGES; do
        PACKAGES=$(echo "$PACKAGES" | sed "s/\b$package\b//g")
    done)
}

install_missing_packages() {
    check_installed_packages
    echo "Installing the following missing packages: $PACKAGES"
    apk add $PACKAGES
}

install_zsh() {
        apk add zsh
        let "TIMEOUT_COUNT++"
        zsh_check
}

zsh_check() {
    if test -f /bin/zsh; then
        echo "Zsh is installed."
        TIMEOUT_COUNT=0
    else
        echo "Zsh is not installed."
        if let "TIMEOUT_COUNT < 3"; then
                echo "Trying to install Zsh..."
                install_zsh
        else
            echo "Failed to install Zsh after multiple attempts. Exiting."
            exit 1
        fi
    fi
}

get_username(){
    read -p 'Your username on this system: ' USER
    echo "System username: $USER"
}

change_shell(){
    get_username
    echo "Checking for Zsh installation..."
    zsh_check
    echo "Changing the shell to zsh..."
    sudo chsh -s /bin/zsh $USER
}

config_git_globals() {
    get_github_info
    git config --global user.name $GH_USERNAME
    git config --global user.email $GH_EMAIL
    git config --global init.defaultBranch $GH_DEFAULT
    echo "Git globals configurated!"
}

install_p10k() {
    change_shell
sudo -u $USER -s -- <<EOL    
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
echo "---------- End of Line ----------"
EOL
    echo "P10k installed... restart shell to initiate configurator."
}

exec bash <<'EOB' 
PACKAGES="git nano zsh curl sudo neofetch shadow util-linux"
FUNCS_TO_CALL=()

read -p "Do you want to configure the git globals with your Github info? (y/n) " call_func1
if echo "$call_func1" | grep -Eq "^[Yy]$"; then
    FUNCS_TO_CALL+=("config_git_globals")
fi


echo "Wird dies ein Gnome-Desktop oder ein Server sein?"
echo "Desktop-Installationen erfordern zuerst die Installation eines Nerds."
read -p "(1) Server || (2) Desktop: " INSTALL_TYPE

case $INSTALL_TYPE in
    1 | Server | server | 1337)
        echo "Cool! Es wird ein Server sein!";;
    2 | Desktop | desktop | gnome | noob)
        echo "Desktop! Gnome ist das Beste!"
        FUNCS_TO_CALL+=("check_nerd_font");;
    *) # Added missing bracket
        echo "Ich bin mir nicht sicher, was Sie wollen ... Versuchen Sie es erneut? (I'm not sure what you want... try again?)"
        exit 1;;
esac



read -p "Do you want to install Powerlevel 10k? (y/n) " call_func2
if echo "$call_func2"  ^[Yy]$ ]]; then
    FUNCS_TO_CALL+=("install_p10k")
fi

# Check for installed packages
check_installed_packages
echo "These packages are required but not installed:"
echo "$PACKAGES"
read -p "Do you want to install the missing packages? (y/n) " call_func3
if [[ $call_func3 =~ ^[Yy]$ ]]; then
    FUNCS_TO_CALL+=("install_missing_packages")
fi

# Call functions in list
for func_name in "${FUNCS_TO_CALL[@]}"; do
    case $func_name in
        "config_git_globals") config_git_globals ;;
        "check_nerd_font") check_nerd_font ;;
        "install_missing_packages") install_missing_packages ;;
        "install_p10k") install_p10k ;;
        *) echo "Invalid name h@x0r, lol: $func_name"; exit 1337 ;;
    esac
done

EOB