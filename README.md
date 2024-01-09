# Configulus

___Update___  //12SEP2023
> I'm climing the steep learning curve of NixOS / Flakes / Home-Manager... this repo is now more of a scratch pad of scrips and code and whatnots. Long term plan: move this stuff to gists and Configulus repo will contain my NixOS configs and home dotfiles. I've also discovered the joy of tiling window managers. Gnome/Ubuntu love is now depreciated 😉

This is a collection of scripts that I use to setup Linux workstations. I prefer ~~Gnome~~ Hyprland, ZSH, Powerlevel10k, Alpine & ~~Ubuntu~~ **NixOS** Linux (I would daily drive Alpine ~~Gnome~~ i3wm if Alpine was glbic and not musl libc based), VSCode, and Chrome (not Chromium). I got tired of all the google searching for "how do I install that thing again?" and typing all those commands! 

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
  5. (Alpine {root}) `apk add git zsh bash nano neofetch wget curl shadow`
  6. (Alpine {root}) `apk add flatpak ; flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo`

## Scripta

**NerdFonts:** 
```bash
sh -c "$(wget -q -O- https://bit.ly/NerdFonts)"
``` 

**Etcher:** 
```bash
sh -c "$(wget -q -O- https://bit.ly/etcher-install)"
```

**balena-cli:** 
```bash
sh -c "$(wget -q -O- https://bit.ly/balena-cli)"
```

-or- 

```bash
sh -c "$(wget -q -O- https://bit.ly/balena-cli)" -s <version>
```

**gh-cli:**
```bash
curl https://shortenedurl | bash -s
```

**Powerlevel10k:** 
```bash
sh -c "$(wget -q -O- https://bit.ly/powerlevel10k)"
```

**Powerlevel10k Alpine:** 
```bash
sh -c "$(wget -q -O- https://bit.ly/p10k-alpine)"
```

**Alpine KVM Install**
```bash
sh -c "$(wget -q -O- https://bit.ly/alpine-kvm)"
```

**NVM:**
```bash
wget -qO- https://bit.ly/NVM-Install | bash
```

**Nano Syntax:**
```bash
curl https://raw.githubusercontent.com/scopatz/nanorc/master/install.sh | sh
```

## Habemus

Neofetch ubuntu issue
```bash
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
