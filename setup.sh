#!/bin/bash

if [ $# -ne 2 ];
then
    echo "Please supply git user.email and git user.name as \$1 and \$2"
    exit
fi

dir="$HOME/dotfiles"

ln -sfv $dir/config/fish ~/.config/fish
ln -sfv $dir/vimrc ~/.vimrc
ln -sfv $dir/vim ~/.vim
ln -sfv $dir/bashrc ~/.bashrc

sudo pacman -Syu --noconfirm
sudo pacman -S vim git ack fish --needed --noconfirm

pushd ~/.vim
git clone https://github.com/VundleVim/Vundle.vim.git bundle/Vundle.vim
popd

vim +PluginInstall +qall

git config --global user.email "\"$1\""
git config --global user.name "\"$2\""
git config --global core.editor vim

git config --global alias.co 'checkout'
git config --global alias.br 'branch'
git config --global alias.ci 'commit'
git config --global alias.st 'status'
git config --global alias.re 'remote'
