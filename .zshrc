# Created by newuser for 5.8.1

# setup path for dotfiles
export DOTFILES=$HOME/dotfiles
# export VIMINIT=$DOTFILES/.vimrc
# export VIMRUNTIME=$DOTFILES/.vim

# # make dotfiles dir
# if [ ! -d $DOTFILES ]; then
#     mkdir $DOTFILES
# fi
# 
# # install Vundle
# if [ ! -e $HOME/.vim/bundle/Vundle.vim ]; then
#     git clone https://github.com/VundleVim/Vundle.vim.git $HOME/.vim/bundle/Vundle.vim
# fi
# # install zsh-autosuggestions
# if [ ! -e $DOTFILES/.zsh/zsh-autosuggestions ]; then
#     git clone https://github.com/zsh-users/zsh-autosuggestions $DOTFILES/.zsh/zsh-autosuggestions
# fi
# # install zsh-syntax-highlighting
# if [ ! -e $DOTFILES/.zsh/zsh-users/zsh-syntax-highlighting ]; then
#     git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $DOTFILES/.zsh/zsh-users/zsh-syntax-highlighting
# fi

# source setting files
source $DOTFILES/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
source $DOTFILES/.zsh/zsh-users/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# command history setting
# File save to
export HISTFILE=${HOME}/.zsh_history
# Number saved in memory
export HISTSIZE=1000
# Number saved in file
export SAVEHIST=10000
# No duplication 
setopt hist_ignore_dups
# Recort initial and last
setopt EXTENDED_HISTORY

# No waring sound
setopt NO_BEEP
# Vim-like keybind
bindkey -v

# alias for rsync
alias rysnc='rsync -ahv --info=progress2'

# completion setting
autoload -Uz compinit
compinit
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
zstyle ':completion:*' list-colors 'di=34' 'ln=36' 'ex=32'
setopt COMPLETE_IN_WORD

# ls with colors
if [ -f $DOTFILES/.colorrc ]; then
    eval `dircolors $DOTFILES/.colorrc`
    alias ls='ls --color=auto'
fi

# git
autoload -Uz vcs_info
setopt prompt_subst
zstyle ':vcs_info:git:*' check-for-changes true
zstyle ':vcs_info:git:*' stagestr "F{magenta}!"
zstyle ':vcs_info:git:*' unstagedstr "%F{yellow}+"
zstyle ':vcs_info:*' formats "%F{cyan}%c%u[%b]%f"
zstyle ':vcs_info:*' actionformats '[%b|%a]'
precmd () { vcs_info }

# Setting prompt
function zle-line-init zle-keymap-select {
    case $KEYMAP in
        vicmd)
        PROMPT='%F{014}[%n@%m]%f %F{cyan}$vcs_info_msg_0_%f %F{009}CMD%f %# %d
%F{100}${VIRTUAL_ENV:+(${VIRTUAL_ENV##*/})}%f%F{028}${CONDA_PREFIX:+(${CONDA_PREFIX##*/})}%f>>'
        ;;
        main|vins)
        PROMPT='%F{014}[%n@%m]%f %F{cyan}$vcs_info_msg_0_%f %F{011}INS%f %# %d
%F{100}${VIRTUAL_ENV:+(${VIRTUAL_ENV##*/})}%f%F{028}${CONDA_PREFIX:+(${CONDA_PREFIX##*/})}%f>>'
        ;;
    esac
    zle reset-prompt
}
zle -N zle-line-init
zle -N zle-keymap-select

# load local machine settings
if [ -f ~/.zshrc_local ]; then
    source ~/.zshrc_local
fi

# auto zcompile after modification
if [ ~/.zshrc -nt ~/.zshrc.zwc ]; then
    zcompile ~/.zshrc
fi

