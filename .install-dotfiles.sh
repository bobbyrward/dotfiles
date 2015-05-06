#!/bin/bash

if [ ! $(which git) ]; then
	if [ ! $(which apt-get) ]; then
		echo "Install git first"
		exit 1
	fi

	sudo apt-get install -y git
fi

DOTFILES_DIR=~/.dotfiles

if [ -d "$DOTFILES_DIR" ]; then
	cd $DOTFILES_DIR
	git pull
else
	git clone https://github.com/bobbyrward/dotfiles.git $DOTFILES_DIR
	cd $DOTFILES_DIR
fi

find $DOTFILES_DIR -type f -not -path "$DOTFILES_DIR/.git/*" -exec cp {} ~ \;

source ~/.bashrc
