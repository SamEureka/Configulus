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
  5. (Alpine {root}) `apk add git zsh bash nano neofetch wget curl`
  6. (Alpine {root}) `apk add flatpak ; flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo`

## Scripta

**NerdFonts:** `sh -c "$(wget -q -O- https://bit.ly/NerdFonts)"` 

**Etcher:** `curl https://shortenedurl | bash -s`

**balena-cli:** 

`sh -c "$(wget -q -O- https://bit.ly/balena-cli)"` 

-or- 

`sh -c "$(wget -q -O- https://bit.ly/balena-cli)" -s <version>`

**gh-cli:** `curl https://shortenedurl | bash -s`

**Powerlevel10k:** `sh -c "$(wget -q -O- https://bit.ly/powerlevel10k)"`

**Powerlevel10k Alpine:** `sh -c "$(wget -q -O- https://bit.ly/p10k-alpine)"`

**NVM:** `wget -qO- https://bit.ly/NVM-Install | bash`

## Habemus

Neofetch ubuntu issue
```
$ git diff neofetch| cat -A
diff --git a/neofetch b/neofetch$
index 48b96d21..d42cc3ea 100755$
--- a/neofetch$
+++ b/neofetch$
@@ -3982,8 +3982,8 @@ get_cols() {$
         printf -v block_spaces "%${block_height}s"$
 $
         # Convert the spaces into rows of blocks.$
-        [[ "$blocks"  ]] && cols+="${block_spaces// /${blocks}^[[mnl}"$
-        [[ "$blocks2" ]] && cols+="${block_spaces// /${blocks2}^[[mnl}"$
+        [[ "$blocks"  ]] && cols+="${block_spaces// /${blocks}^[\[mnl}"$
+        [[ "$blocks2" ]] && cols+="${block_spaces// /${blocks2}^[\[mnl}"$
 $
         # Add newlines to the string.$
         cols=${cols%%nl}$
 ```
