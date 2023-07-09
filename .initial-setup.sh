#!/bin/bash

curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

source $HOME/.cargo/env

sudo add-apt-repository --yes ppa:neovim-ppa/stable
sudo apt-get install --yes build-essential python3-dev python3-pip neovim
cargo install exa bat fd-find ripgrep kx fnm

eval "$(fnm env --use-on-cd)"

fnm install 18
fnm default 18

nvim +PlugInstall +qall
