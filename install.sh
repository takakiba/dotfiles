#!/bin/bash

set -u

BASEDIR=$(dirname $0)
cd $BASEDIR

for f in .??*; do
    [ "$f" = '.git' ] && continue
    [ "$f" = '.gitignore' ] && continue
    [ "$f" = '.zsh' ] && continue

    ln -snfv ${PWD}/"$f" $HOME/
done

# setup path for dotfiles
export DOTFILES=$HOME/dotfiles
# export VIMINIT=$DOTFILES/.vimrc
# export VIMRUNTIME=$DOTFILES/.vim

# make dotfiles dir
if [ ! -d $DOTFILES ]; then
    mkdir $DOTFILES
fi

# install Vundle
if [ ! -e $HOME/.vim/bundle/Vundle.vim ]; then
    git clone https://github.com/VundleVim/Vundle.vim.git $HOME/.vim/bundle/Vundle.vim
fi
# install zsh-autosuggestions
if [ ! -e $DOTFILES/.zsh/zsh-autosuggestions ]; then
    git clone https://github.com/zsh-users/zsh-autosuggestions $DOTFILES/.zsh/zsh-autosuggestions
fi
# install zsh-syntax-highlighting
if [ ! -e $DOTFILES/.zsh/zsh-users/zsh-syntax-highlighting ]; then
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $DOTFILES/.zsh/zsh-users/zsh-syntax-highlighting
fi

# prepare default teminal color setting file
if [ ! -f ~/term_color ]; then
    cp $DOTFILES/term_color.template ~/term_color
fi

