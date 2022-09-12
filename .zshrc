# Created by newuser for 5.8.1

# setup path for dotfiles
export DOTFILES=$HOME/dotfiles

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
alias rsync='rsync -ahv --info=progress2'

# completion setting
autoload -Uz compinit
compinit
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
# zstyle ':completion:*' list-colors 'di=34' 'ln=36' 'ex=32'
setopt COMPLETE_IN_WORD

# ls with colors
case `uname` in
    "Linux") eval `dircolors $DOTFILES/.colorrc` && alias ls='ls --color=auto';;
    "Darwin") eval `gdircolors $DOTFILES/.colorrc` && alias ls='gls --color=auto';;
esac

# Set color completion
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}

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
terminal_color='002'
if [ -f ~/term_color ]; then
    source ~/term_color
fi
function zle-line-init zle-keymap-select {
    case $KEYMAP in
        vicmd)
        PROMPT='%F{${terminal_color}}[%n@%m]%f %F{cyan}$vcs_info_msg_0_%f %F{009}CMD%f %# %d
%F{001}${DIRENV_DIR:+DIRENV@(${DIRENV_DIR})}%f
%F{100}${VIRTUAL_ENV:+(${VIRTUAL_ENV##*/})}%f%F{028}${CONDA_PREFIX:+(${CONDA_PREFIX##*/})}%f>>'
        ;;
        main|vins)
        PROMPT='%F{${terminal_color}}[%n@%m]%f %F{cyan}$vcs_info_msg_0_%f %F{011}INS%f %# %d
%F{001}${DIRENV_DIR:+DIRENV@(${DIRENV_DIR})}%f
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

