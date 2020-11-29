#!/bin/bash
nitrogen --restore &  # Wallpaper
compton &
# /etc/xdg/autostart 
/usr/lib/x86_64-linux-gnu/libexec/org_kde_powerdevil &
# Lockscreen al suspender
xss-lock -l -- multilockscreen --lock blur &
latte-dock &

