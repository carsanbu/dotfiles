#!/bin/bash
mkdir -p .install && cd .install

echo "******* INSTALLING LAZYGIT *******"
(
	wget https://github.com/jesseduffield/lazygit/releases/download/v0.44.0/lazygit_0.44.0_Linux_x86_64.tar.gz
	tar xzvf lazygit_0.44.0_Linux_x86_64.tar.gz lazygit
	mv lazygit ~/.local/bin
)
