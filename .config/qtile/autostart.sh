#!/bin/bash
nitrogen --restore &  # Wallpaper
picom --experimental-backends -b
# /etc/xdg/autostart mientras no pueda usar https://github.com/jceb/dex 
/usr/lib/x86_64-linux-gnu/libexec/org_kde_powerdevil &
/usr/lib/x86_64-linux-gnu/libexec/polkit-kde-authentication-agent-1 &
# Lockscreen al suspender
xss-lock -l -- multilockscreen --lock blur &
#latte-dock &
# Notificaciones
deadd-notification-center &
#dunst &
#conky -d
eww
eww open main_window
#copyq &
#flameshot &
#kdeconnect-indicator &
