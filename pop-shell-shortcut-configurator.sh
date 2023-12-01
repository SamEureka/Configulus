#!/usr/bin/env bash

#░█▀█░█▀█░█▀█░░░█▀▀░█░█░█▀▀░█░░░█░░░░░█▀▀░█▀█░█▀█░█▀▀░▀█▀░█▀▀░█░█░█▀▄░█▀█░▀█▀░█▀▄
#░█▀▀░█░█░█▀▀░░░▀▀█░█▀█░█▀▀░█░░░█░░░░░█░░░█░█░█░█░█▀▀░░█░░█░█░█░█░█▀▄░█▀█░░█░░█▀▄
#░▀░░░▀▀▀░▀░░░░░▀▀▀░▀░▀░▀▀▀░▀▀▀░▀▀▀░░░▀▀▀░▀▀▀░▀░▀░▀░░░▀▀▀░▀▀▀░▀▀▀░▀░▀░▀░▀░░▀░░▀░▀
# Original: https://github.com/pop-os/shell/blob/master_jammy/scripts/configure.sh
# SamEureka: 

set -ex

shortcut_applied() {
  # Check if user confirmed overriding shortcuts
  if test -f "./.confirm_shortcut_change"; then
    echo "Shortcut change already confirmed"
    return 0
  fi

  read -p "Pop shell will override your default shortcuts. Are you sure? (y/n) " CONT
  if test "$CONT" = "y"; then
    touch "./.confirm_shortcut_change"
    return 1
  else
    echo "Cancelled"
    return 0
  fi
}

set_keybindings() {
  if shortcut_applied; then
    return 0
  fi

  left="h"
  down="j"
  up="k"
  right="l"

  KEYS_GNOME_WM=/org/gnome/desktop/wm/keybindings 
  KEYS_GNOME_SHELL=/org/gnome/shell/keybindings
  KEYS_MUTTER=/org/gnome/mutter/keybindings
  KEYS_MEDIA=/org/gnome/settings-daemon/plugins/media-keys
  KEYS_MUTTER_WAYLAND_RESTORE=/org/gnome/mutter/wayland/keybindings/restore-shortcuts
  MUTTER=/org/gnome/mutter
  PREFS_GNOME_WM=/org/gnome/desktop/wm/preferences
  SHELL=/org/gnome/shell

set_gnome_setting() {
  key=$1
  value=$2
  dconf write $key $value
}

# Define GNOME settings as an associative array
declare -A settings

settings=(
  ["${KEYS_MUTTER_WAYLAND_RESTORE}"]="'@as []'"
  ["${KEYS_GNOME_WM}/minimize"]="'@as ['<Super>comma']'"
  ["${KEYS_GNOME_SHELL}/open-application-menu"]="'@as []'"
  ["${KEYS_GNOME_SHELL}/toggle-message-tray"]="'@as ['<Super>v']'"
  ["${KEYS_GNOME_SHELL}/toggle-overview"]="'@as []'"
  ["${KEYS_GNOME_WM}/switch-to-workspace-left"]="'@as []'"
  ["${KEYS_GNOME_WM}/switch-to-workspace-right"]="'@as []'"
  ["${KEYS_GNOME_WM}/maximize"]="'@as []'"
  ["${KEYS_GNOME_WM}/unmaximize"]="'@as []'"
  ["${KEYS_GNOME_WM}/move-to-monitor-up"]="'@as []'"
  ["${KEYS_GNOME_WM}/move-to-monitor-down"]="'@as []'"
  ["${KEYS_GNOME_WM}/move-to-monitor-left"]="'@as []'"
  ["${KEYS_GNOME_WM}/move-to-workspace-down"]="'@as []'"
  ["${KEYS_GNOME_WM}/move-to-workspace-up"]="'@as []'"
  ["${KEYS_GNOME_WM}/move-to-monitor-right"]="'@as []'"
  ["${KEYS_GNOME_WM}/switch-to-workspace-down"]="['<Primary><Super>Down','<Primary><Super>${down}']"
  ["${KEYS_GNOME_WM}/switch-to-workspace-up"]="['<Primary><Super>Up','<Primary><Super>${up}']"
  ["${KEYS_MUTTER}/toggle-tiled-left"]="'@as []'"
  ["${KEYS_MUTTER}/toggle-tiled-right"]="'@as []'"
  ["${KEYS_GNOME_WM}/toggle-maximized"]="['<Super>m']"
  ["${KEYS_MEDIA}/screensaver"]="['<Super>Escape']"
  ["${KEYS_MEDIA}/home"]="['<Super>f']"
  ["${KEYS_MEDIA}/email"]="['<Super>e']"
  ["${KEYS_MEDIA}/www"]="['<Super>b']"
  ["${KEYS_MEDIA}/terminal"]="['<Super>t']"
  ["${KEYS_MEDIA}/rotate-video-lock-static"]="'@as []'"
  ["${KEYS_GNOME_WM}/close"]="['<Super>q', '<Alt>F4']"
  ["${MUTTER}/dynamic-workspaces"]="false"
  ["${PREFS_GNOME_WM}/num-workspaces"]="10"
  ["${SHELL}/disable-user-extensions"]="false"
  ["${MUTTER}/workspaces-only-on-primary"]="true"
)

# Loop over the settings and apply them
for key in "${!settings[@]}"; do
  eval "set_gnome_setting $key ${settings[$key]}"
done

  # Unset switch-to-application keybindings that may conflict
  for i in {1..10}
  do
    actionItem="${KEYS_GNOME_WM}/switch-to-application-${i}"
    if dconf write "${actionItem}" "['']"; then
      echo "Unset ${actionItem}"
    else
      echo "Failed to unset ${actionItem}"
    fi   
  done

  # Set the keybindings for the <Super>number switching
  for j in {1..10}
  do
    actionItem="${KEYS_GNOME_WM}/switch-to-workspace-${j}"
    if dconf write "${actionItem}" "['<Super>${j}']"; then
      echo "Set ${actionItem}"
    else
      echo "errror, does not compute ${actionItem} ${j}"
    fi
  done

  # Set the keykindings for moving applications to numbered workspaces
  for k in {1..10}
  do
    actionItem="${KEYS_GNOME_WM}/move-to-workspace-${k}"
    if dconf write "${actionItem}" "['<Super><Shift>${k}']"; then
      echo "Set ${actionItem} ${k}"
    else
      echo "errror, does not compute ${actionItem} ${k}"
    fi
  done

  echo "GNOME settings applied successfully."
}

set_keybindings

# Use a window placement behavior which works better for tiling

if gnome-extensions list | grep native-window; then
    gnome-extensions enable $(gnome-extensions list | grep native-window)
fi
