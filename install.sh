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

# make dotfiles dir
if [ ! -d $DOTFILES ]; then
    mkdir $DOTFILES
fi

# install Vundle
if [ ! -e $HOME/.vim/bundle/Vundle.vim ]; then
    git clone https://github.com/VundleVim/Vundle.vim.git $HOME/.vim/bundle/Vundle.vim
fi
# install zsh-autosuggestions
if [ ! -e $DOTFILES/zsh/zsh-autosuggestions ]; then
    git clone https://github.com/zsh-users/zsh-autosuggestions $DOTFILES/zsh/zsh-autosuggestions
fi
# install fast-syntax-highlighting
if [ ! -e $DOTFILES/zsh/fast-syntax-highlighting ]; then
    git clone https://github.com/zdharma-continuum/fast-syntax-highlighting $DOTFILES/zsh/fast-syntax-highlighting
fi

if [ ! -e $DOTFILES/starship ]; then
    curl -sS https://starship.rs/install.sh | sh -s -- --bin-dir $DOTFILES --yes
fi

# prepare default teminal color setting file
if [ ! -f ~/term_color ]; then
    cp $DOTFILES/term_color.template ~/term_color
fi

