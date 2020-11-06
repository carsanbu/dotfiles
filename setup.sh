#!/bin/bash

 sudo apt install git zsh stow

cd .config

stow -t ../../.config mako
stow -t ../../.config/mako mako
stow -t ../../.config/sway sway
stow -t ../../.config/waybar waybar
stow -t ../../.config/waybar waybar
stow -t ../../.config/nvim nvim

if [ ! -L ~/.zshrc ]; then
ln -s ~/.dotfiles.d/zsh/.zshrc ~/.zshrc
fi

if [ ! -d ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom} ]; then
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
fi

if [ ! -d ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k ]; then
	git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
	ln -s ~/.dotfiles.d/zsh/.p10k.zsh ~/.p10k.zsh
fi

