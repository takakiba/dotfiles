#!/bin/bash

DOT_DIRECTORY="${HOME}/dotfiles"
DOT_TARBALL="https//github.com/takakiba/dotfiles/tarball/master"
REMOTE_URL="git@github.com:takakiba/dotfiles.git"

has() {
    type "$1" > /dev/null 2>&1
}

if [ ! -d ${DOT_DIRECTORY} ]; then
    echo "Downloading dotfiles..."
    mkdir ${DOT_DIRECTORY}

    if type "git" > /dev/null 2&1; then
        git clone --recursive "${REMOTE_URL}" "${DOT_DIRECTORY}"
    else
        curl -fsSLo ${HOME}/dotfiles.tar.gz ${DOT_TARBALL}
        tar -zxf ${HOME}/dotfiles.tar.gz --strip-components 1 -C ${DOT_DIRECTORY}
        rm -f ${HOME}/dotfiles.tar.gz
    fi

    echo $(tput setaf 2)Download dotfiles complete!. $(tput sgr0)

fi


link_files() {
    cd ${DOT_DIRECTORY}

    for f in .??*
    do
        [[ ${f} = ".git" ]] && continue
        [[ ${f} = ".gitignore" ]] && continue
        ln -snfv ${DOT_DIRECTORY}/${f} ${HOME}/${f}
    done
    echo $(tput setaf 2)Deploy dotfiles complete!. $(tput sgr0)
}

initialize() {
    if has "brew"; then
        echo "$(tput setaf 2)Already installed Homebrew $(tput sgr0)"
    else
        echo "Installing Homebrew..."
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    fi

    if has "brew"; then
        echo "Updating Homebrew..."
        brew update && brew upgrade
        [[ $? ]] && echo "$(tput setaf 2)Update Homebrew complete. $(tput sgr0)"
    fi
}

