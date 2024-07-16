#!/bin/bash

echo "******* UPGRADING THE SYSTEM *******"
apt update
apt upgrade -y
echo "******* INSTALL DEPENDECIES *******"
apt install -y curl git zsh neovim neofetch newsboat nitrogen rofi python3-pip python3-dev python3-setuptools fzf xss-lock dunst conky-std silversearcher-ag picom ansiweather ranger ueberzug tmux tmuxp
# Dependencies qtile
apt install -y libpangocairo-1.0-0 python3-xcffib python3-cairocffi libiw-dev
# Dependencies flashfocus
apt install -y libxcb-render0-dev libffi-dev
# Dependencies i3lock-color 
apt install -y imagemagick autoconf gcc make pkg-config libpam0g-dev libcairo2-dev libfontconfig1-dev libxcb-composite0-dev libev-dev libx11-xcb-dev libxcb-xkb-dev libxcb-xinerama0-dev libxcb-randr0-dev libxcb-image0-dev libxcb-util0-dev libxcb-xrm-dev libxkbcommon-dev libxkbcommon-x11-dev libjpeg-dev  
apt install -y meson ninja-build cmake
# Dependencies eww
apt install -y libgtk-3-dev
