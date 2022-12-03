#!/bin/bash
sudo ./scripts/installdeps.sh

./scripts/installZSH.sh 

echo "******* INSTALLING PACKAGES *******"
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

pip3 install thefuck
pip3 install git+https://github.com/will8211/unimatrix.git
pip3 install qtile iwlib flashfocus neovim-remote ranger-fm ueberzug


echo "******* LINKING CONFIGS *******"
stow -t ../.config .config
stow -t ../.local .local

echo '[Desktop Entry]
Name=Qtile
Comment=Qtile Session
Exec='$HOME'/.local/bin/qtile start
Type=Application
Keywords=wm;tiling
EOF' | sudo tee /usr/share/xsessions/qtile.desktop > /dev/null 

curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
source $HOME/.cargo/env

mkdir -p .install && cd .install

echo "******* INSTALLING ALACRITTY *******"
(
	# TODO: Comprobar que alacrity no está instalado
	git clone https://github.com/alacritty/alacritty.git && cd alacritty
	rustup override set stable
	rustup update stable
	cargo build --release

	cp target/release/alacritty /usr/local/bin # or anywhere else in $PATH
	cp extra/logo/alacritty-term.svg /usr/share/pixmaps/Alacritty.svg
	desktop-file-install extra/linux/Alacritty.desktop
	update-desktop-database
)

echo "******* INSTALLING LOCKSCREEN *******"
(
	git clone https://github.com/Raymo111/i3lock-color.git && cd i3lock-color
	chmod +x build.sh && ./build.sh
	chmod +x install-i3lock-color.sh && ./install-i3lock-color.sh
)

(
	git clone https://github.com/jeffmhubbard/multilockscreen && cd multilockscreen
	sudo install -Dm 755 multilockscreen /usr/local/bin/multilockscreen
	multilockscreen -u ~/.local/share/wallpapers/cyberpunk-minimalistic-wallpapers-wp7255027.jpg
)

echo "******* INSTALLING WIDGETS *******"
(
	git clone https://github.com/elkowar/eww && cd eww
	cargo build --release
	cd target/release
	chmod +x ./eww
	cp eww ~/.local/bin/
)
cd ../../

echo "******* INSTALLING RANGER *******"
mkdir -p ~/.config/ranger/plugins
git clone https://github.com/alexanderjeurissen/ranger_devicons ~/.config/ranger/plugins/ranger_devicons

cd ..
