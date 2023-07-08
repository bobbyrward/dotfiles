#!/bin/bash

install_rust

sudo add-apt-repository ppa:neovim-ppa/stable
sudo apt-get install build-essential python3-dev python3-pip neovim
cargo install exa bat fd-find ripgrep kx fnm

fnm install 18
fnm default 18

nvim +PlugInstall +qall
