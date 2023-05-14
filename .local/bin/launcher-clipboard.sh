#!/usr/bin/env bash

## Author  : Aditya Shakya
## Mail    : adi1090x@gmail.com
## Github  : @adi1090x
## Twitter : @adi1090x

# Available Styles
# >> Created and tested on : rofi 1.6.0-1
#
# blurry	blurry_full		kde_simplemenu		kde_krunner		launchpad
# gnome_do	slingshot		appdrawer			appdrawer_alt	appfolder
# column	row				row_center			screen			row_dock		row_dropdown

theme="blurry-list"
dir="$HOME/.config/rofi/themes"

#rofi -no-lazy-grab -combi-modi drun,ssh -show combi -modi combi -theme $dir/"$theme"
rofi -modi "clipboard:greenclip print" -show clipboard -run-command '{cmd}' -theme $dir/"$theme"

