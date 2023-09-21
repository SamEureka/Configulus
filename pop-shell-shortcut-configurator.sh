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


  # Disable incompatible shortcuts
  # Restore the keyboard shortcuts: disable <Super>Escape
  dconf write ${KEYS_MUTTER_WAYLAND_RESTORE} "@as []"
  # Hide window: disable <Super>h
  dconf write ${KEYS_GNOME_WM}/minimize "@as ['<Super>comma']"
  # Open the application menu: disable <Super>m
  dconf write ${KEYS_GNOME_SHELL}/open-application-menu "@as []"
  # Toggle message tray: disable <Super>m
  dconf write ${KEYS_GNOME_SHELL}/toggle-message-tray "@as ['<Super>v']"
  # Show the activities overview: disable <Super>s
  dconf write ${KEYS_GNOME_SHELL}/toggle-overview "@as []"
  # Switch to workspace left: disable <Super>Left
  dconf write ${KEYS_GNOME_WM}/switch-to-workspace-left "@as []"
  # Switch to workspace right: disable <Super>Right
  dconf write ${KEYS_GNOME_WM}/switch-to-workspace-right "@as []"
  # Maximize window: disable <Super>Up
  dconf write ${KEYS_GNOME_WM}/maximize "@as []"
  # Restore window: disable <Super>Down
  dconf write ${KEYS_GNOME_WM}/unmaximize "@as []"
  # Move to monitor up: disable <Super><Shift>Up
  dconf write ${KEYS_GNOME_WM}/move-to-monitor-up "@as []"
  # Move to monitor down: disable <Super><Shift>Down
  dconf write ${KEYS_GNOME_WM}/move-to-monitor-down "@as []"

  # Super + direction keys, move window left and right monitors, or up and down workspaces
  # Move window one monitor to the left
  dconf write ${KEYS_GNOME_WM}/move-to-monitor-left "@as []"
  # Move window one workspace down
  dconf write ${KEYS_GNOME_WM}/move-to-workspace-down "@as []"
  # Move window one workspace up
  dconf write ${KEYS_GNOME_WM}/move-to-workspace-up "@as []"
  # Move window one monitor to the right
  dconf write ${KEYS_GNOME_WM}/move-to-monitor-right "@as []"

  # Super + Ctrl + direction keys, change workspaces, move focus between monitors
  # Move to workspace below
  dconf write ${KEYS_GNOME_WM}/switch-to-workspace-down "['<Primary><Super>Down','<Primary><Super>${down}']"
  # Move to workspace above
  dconf write ${KEYS_GNOME_WM}/switch-to-workspace-up "['<Primary><Super>Up','<Primary><Super>${up}']"

  # Disable tiling to left / right of screen
  dconf write ${KEYS_MUTTER}/toggle-tiled-left "@as []"
  dconf write ${KEYS_MUTTER}/toggle-tiled-right "@as []"

  # Toggle maximization state
  dconf write ${KEYS_GNOME_WM}/toggle-maximized "['<Super>m']"
  # Lock screen
  dconf write ${KEYS_MEDIA}/screensaver "['<Super>Escape']"
  # Home folder
  dconf write ${KEYS_MEDIA}/home "['<Super>f']"
  # Launch email client
  dconf write ${KEYS_MEDIA}/email "['<Super>e']"
  # Launch web browser
  dconf write ${KEYS_MEDIA}/www "['<Super>b']"
  # Launch terminal
  dconf write ${KEYS_MEDIA}/terminal "['<Super>t']"
  # Rotate Video Lock
  dconf write ${KEYS_MEDIA}/rotate-video-lock-static "@as []"

  # Close Window
  dconf write ${KEYS_GNOME_WM}/close "['<Super>q', '<Alt>F4']"

  # Setup <super>numbered workspace switching
  dconf write ${MUTTER}/dynamic-workspaces false
  dconf write ${PREFS_GNOME_WM}/num-workspaces 10

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
}

if ! command -v gnome-extensions >/dev/null; then
    echo 'You must install gnome-extensions to configure or enable via this script'
    '(`gnome-shell` on Debian systems, `gnome-extensions` on openSUSE systems.)'
    exit 1
fi

set_keybindings

# Make sure user extensions are enabled
dconf write ${SHELL}/disable-user-extensions false

# Use a window placement behavior which works better for tiling

if gnome-extensions list | grep native-window; then
    gnome-extensions enable $(gnome-extensions list | grep native-window)
fi

# Workspaces spanning displays works better with Pop Shell
dconf write ${MUTTER}/workspaces-only-on-primary false
