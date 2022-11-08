# Configulus

This is a collection of scripts that I use to setup Linux workstations. I prefer Gnome, ZSH, Powerlevel10k, Alpine & Ubuntu Linux (If I could get Chrome Stable to run on Alpine, I'd never look back!), VSCode, and Chrome (not Chromium). I got tired of all the google searching for "how do I install that thing again?" and typing all those commands! 

### Rami
* 'main' contains Ubuntu specific scripts
* 'alpine' containes Alpine Linux scripts

### Temporibus
* Phase one of this project is to get the scripts working and install the things I like. 
* Phase two is to potentially auto-config my Gnome settings and extensions. 
* Phase three is to pair down (auto-remove) all the bloaty stuff. Applications that I am not likely to ever use and normally ignore.    

## Primi Gradus

  1. `export GH_EMAIL=<your github email>`
  2. `export GH_USERNAME=<your github username>`
  3. `export SHELL=<path to zsh>`
  4. `sudo apt update && sudo apt -qqq -y install git zsh bash nano neofetch wget curl`

## Scripta

**Etcher:** `curl https://shortenedurl | bash -s`

**balena-cli:** `sh -c "$(wget -q -O- https://bit.ly/balena-cli)"`

**gh-cli** `curl https://shortenedurl | bash -s`

**Powerlevel10k** `curl https://shortenedurl | bash -s`

