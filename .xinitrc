#!/usr/bin/env zsh

xset b off

# xrdb -I$XDG_CONFIG_HOME/Xresources $XDG_CONFIG_HOME/Xresources/config.x

source "/etc/X11/xinit/xinitrc.d/50-systemd-user.sh"

eval "$(/usr/bin/gnome-keyring-daemon --start)"
export SSH_AUTH_SOCK

mkdir -p "$XDG_DATA_HOME/keyrings"

i3
i3
i3

