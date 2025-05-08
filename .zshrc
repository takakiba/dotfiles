# Created by newuser for 5.8.1

# setting for command timer
zmodload zsh/datetime 2>/dev/null
typeset -g __START_TIME

# setup path for dotfiles
export DOTFILES=$HOME/dotfiles

# source setting files
source $DOTFILES/zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
source $DOTFILES/zsh/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh

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
alias rsync='rsync -ahvc --info=progress2 --append-verify'

# alias to print color map
alias printc='for c in {000..255}; do echo -n "\e[38;5;${c}m $c"; [ $(($c%16)) -eq 15 ] && echo;done'

# completion setting
autoload -Uz compinit
compinit -C
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
zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:git:*' check-for-changes true
zstyle ':vcs_info:git:*' stagestr "F{magenta}!"
zstyle ':vcs_info:git:*' unstagedstr "%F{yellow}+"
zstyle ':vcs_info:*' formats "%F{cyan}%c%u[%b]%f"
zstyle ':vcs_info:*' actionformats '[%b|%a]'
function vcs_precmd () {
    vcs_info
}

# Setting prompt
terminal_color='002'
if [ -f ~/term_color ]; then
    source ~/term_color
fi
function zle-line-init zle-keymap-select {
    APWD=`pwd -P`
    case $KEYMAP in
        vicmd)
        PROMPT='%F{${terminal_color}}[%n@%m]%f %F{cyan}$vcs_info_msg_0_%f %F{009}CMD%f %# %F{034}${DIRENV_DIR:+${DIRENV_DIR$-}}%f${APWD#${DIRENV_DIR:+${DIRENV_DIR#-}}}
%F{100}${VIRTUAL_ENV:+(${VIRTUAL_ENV##*/})}%f%F{028}${CONDA_PREFIX:+(${CONDA_PREFIX##*/})}%f>>'
        ;;
        main|vins)
        PROMPT='%F{${terminal_color}}[%n@%m]%f %F{cyan}$vcs_info_msg_0_%f %F{011}INS%f %# %F{034}${DIRENV_DIR:+${DIRENV_DIR#-}}%f${APWD#${DIRENV_DIR:+${DIRENV_DIR#-}}}
%F{100}${VIRTUAL_ENV:+(${VIRTUAL_ENV##*/})}%f%F{028}${CONDA_PREFIX:+(${CONDA_PREFIX##*/})}%f>>'
        ;;
    esac
    zle reset-prompt
}
zle -N zle-line-init
zle -N zle-keymap-select

### set imgcat alias
export PATH=$PATH:$DOTFILES

### setup preview imgages as movie
premov() {
    fps=15.0
    extension="png"

    while (( $# > 0 ))
    do
        case $1 in
            -f)
                fps=$2
                ;;
            -e)
                extension=$2
                ;;
            -*)
                echo 'Invalid option'
                echo 'USAGE: premov [-f FPS -e EXTENSION] target_dir'
                return 1
                ;;
            *)
                tgtdir=$1
                ;;
        esac
        shift
    done

    for pngfile in $tgtdir/*.$extension; do
        # echo $pngfile
        imgcat $pngfile
        sleep $((1.0/$fps))s
    done
}

# timer functions
function preexec() {
    __START_TIME=$EPOCHSECONDS
}

function timer_precmd() {
    if [[ -n $__START_TIME ]]; then
        local elapsed=$((EPOCHSECONDS - __START_TIME))
        if (( elapsed > 5 )); then
            print -P "%F{cyan}Elapsed time: ${elapsed} seconds%f" >&2
        fi
        unset __START_TIME
    fi
}

# hook for timer function
autoload -Uz add-zsh-hook
add-zsh-hook precmd vcs_precmd
add-zsh-hook precmd timer_precmd

# do not record zsh history with error exit
function zshaddhistory() {
    [[ $? -eq 0 ]] && return 0 || return 1
}

# direnv setting
export EDITOR=vim
if command -v direnv >/dev/null 2>&1; then
    eval "$(direnv hook zsh)"
fi



# starship setting
# export STARSHIP_CONFIG=$DOTFILES/starship.toml
# eval "$(starship init zsh)"

# load local machine settings
if [ -f ~/.zshrc_local ]; then
    source ~/.zshrc_local
fi

# auto zcompile after modification
if [ ~/.zshrc -nt ~/.zshrc.zwc ]; then
    zcompile ~/.zshrc
fi




