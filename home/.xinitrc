#!/usr/bin/env zsh

xset b off

# xrdb -I$XDG_CONFIG_HOME/Xresources $XDG_CONFIG_HOME/Xresources/config.x
xrdb -merge $HOME/.Xresources

source "/etc/X11/xinit/xinitrc.d/50-systemd-user.sh"

# Activate Keyring
mkdir -p "$XDG_DATA_HOME/keyrings"
eval "$(/usr/bin/gnome-keyring-daemon --start)"
export SSH_AUTH_SOCK


# launch WM/DE
i3

