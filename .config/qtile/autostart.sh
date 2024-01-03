#!/usr/bin/env bash

# If the process doesn't exists, start one in background
run() {
	if ! pgrep $1 ; then
		$@ &
	fi
}

# Compositor
picom --experimental-backends -b

run keepassxc
run syncthing-gtk
run greenclip daemon	# Clipboard history for rofi
run xss-lock -l -- multilockscreen --lock blur	# Locker
run flashfocus				# Animation on focus
flatpak run org.openrgb.OpenRGB --server &

# /etc/xdg/autostart mientras no pueda usar https://github.com/jceb/dex 
run /usr/lib/x86_64-linux-gnu/libexec/polkit-kde-authentication-agent-1

# Notificaciones
#run $HOME/.local/bin/deadd-notification-center

#run eww daemon
#run eww open main_window

