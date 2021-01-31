#!/bin/bash
nitrogen --restore &  # Wallpaper

picom --experimental-backends -b
# /etc/xdg/autostart mientras no pueda usar https://github.com/jceb/dex 
/usr/lib/x86_64-linux-gnu/libexec/org_kde_powerdevil &
/usr/lib/x86_64-linux-gnu/libexec/polkit-kde-authentication-agent-1 &
# Lockscreen al suspender

#latte-dock &

# Notificaciones
$HOME/.local/bin/deadd-notification-center &

#copyq &
#flameshot &
#kdeconnect-indicator &
xss-lock -l -- multilockscreen --lock blur &

$HOME/.local/bin/eww
$HOME/.local/bin/eww open main_window


