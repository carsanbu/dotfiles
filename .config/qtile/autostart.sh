#!/bin/bash

# If the process doesn't exists, start one in background
run() {
	if ! pgrep $1 ; then
		$@ &
	fi
}

 # Wallpaper
run nitrogen --restore
# Compositor
picom --experimental-backends -b

run flashfocus

# /etc/xdg/autostart mientras no pueda usar https://github.com/jceb/dex 
run /usr/lib/x86_64-linux-gnu/libexec/org_kde_powerdevil
run /usr/lib/x86_64-linux-gnu/libexec/polkit-kde-authentication-agent-1
# Lockscreen al suspender


# Notificaciones
run $HOME/.local/bin/deadd-notification-center

#copyq &
#flameshot &
#kdeconnect-indicator &
run xss-lock -l -- multilockscreen --lock blur

run $HOME/.local/bin/eww
run $HOME/.local/bin/eww open main_window

