#!/bin/bash
nitrogen --restore &  # Wallpaper
#picom -b --blur-background --blur-kern '7,7,0.000003,0.000102,0.000849,0.001723,0.000849,0.000102,0.000003,0.000102,0.003494,0.029143,0.059106,0.029143,0.003494,0.000102,0.000849,0.029143,0.243117,0.493069,0.243117,0.029143,0.000849,0.001723,0.059106,0.493069,0.493069,0.059106,0.001723,0.000849,0.029143,0.243117,0.493069,0.243117,0.029143,0.000849,0.000102,0.003494,0.029143,0.059106,0.029143,0.003494,0.000102,0.000003,0.000102,0.000849,0.001723,0.000849,0.000102,0.000003'
picom -b
# /etc/xdg/autostart mientras no pueda usar https://github.com/jceb/dex 
/usr/lib/x86_64-linux-gnu/libexec/org_kde_powerdevil &
# Lockscreen al suspender
xss-lock -l -- multilockscreen --lock blur &
latte-dock &
# Notificaciones
dunst &
conky -d
