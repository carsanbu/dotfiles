#!/bin/bash
echo "******* UPGRADING THE SYSTEM *******"
apt update
apt upgrade -y
apt install -y curl git zsh stow neovim python3-pip python3-dev python3-setuptools xss-lock dunst conky-std
# Dependencies i3lock-color 
apt install -y imagemagick autoconf gcc make pkg-config libpam0g-dev libcairo2-dev libfontconfig1-dev libxcb-composite0-dev libev-dev libx11-xcb-dev libxcb-xkb-dev libxcb-xinerama0-dev libxcb-randr0-dev libxcb-image0-dev libxcb-util0-dev libxcb-xrm-dev libxkbcommon-dev libxkbcommon-x11-dev libjpeg-dev  
apt install -y meson ninja-build cmake
# Dependencies picom
apt install -y libxext-dev libxcb1-dev libxcb-damage0-dev libxcb-xfixes0-dev libxcb-shape0-dev libxcb-render-util0-dev libxcb-render0-dev libxcb-randr0-dev libxcb-composite0-dev libxcb-image0-dev libxcb-present-dev libxcb-xinerama0-dev libxcb-glx0-dev libpixman-1-dev libdbus-1-dev libconfig-dev libgl1-mesa-dev  libpcre2-dev  libevdev-dev uthash-dev libev-dev libx11-xcb-dev

echo "******* LINKING CONFIGS *******"
stow -t ../.config .config
stow -t ../.local .local

if [ ! -L ~/.zshrc ]; then
stow -t .. zsh
fi

echo "******* INSTALLING SHELL *******"
if [ ! -d ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom} ]; then
	sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)" "" --unattended
	git clone https://github.com/zsh-users/zsh-completions ${ZSH_CUSTOM:=~/.oh-my-zsh/custom}/plugins/zsh-completions
	git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
fi

if [ ! -d ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k ]; then
	git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
	ln -s ~/.dotfiles.d/zsh/.p10k.zsh ~/.p10k.zsh
	mkdir -p ~/.local/share/fonts
	cd ~/.local/share/fonts && curl -fLo "Droid Sans Mono for Powerline Nerd Font Complete.otf" https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/DroidSansMono/complete/Droid%20Sans%20Mono%20Nerd%20Font%20Complete.otf
fi

echo "******* INSTALLING PACKAGES *******"
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

pip3 install thefuck
pip3 install git+https://github.com/will8211/unimatrix.git
pip3 install qtile neovim-remote ranger-fm ueberzug

cp .config/alacrity/shell.sh /usr/local/bin

echo '[Desktop Entry]
Name=Qtile
Comment=Qtile Session
Exec='$HOME'/.local/bin/qtile
Type=Application
Keywords=wm;tiling
EOF' | tee /usr/share/xsessions/qtile.desktop > /dev/null 

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

echo "******* INSTALLING COMPOSITOR *******"
git clone https://github.com/jonaburg/picom
cd picom
meson --buildtype=release . build
ninja -C build
# To install the binaries in /usr/local/bin (optional)
ninja -C build install
cd ..
