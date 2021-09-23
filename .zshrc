#
# .zshrc is sourced in interactive shells.
# It should contain commands to set up aliases,
# functions, options, key bindings, etc.
#

autoload -U compinit
compinit

#allow tab completion in the middle of a word
setopt COMPLETE_IN_WORD

#export LSCOLORS=gxfxxxxxcxxxxxxxxxgxgx
#export LS_COLORS='di=01;36:ln=01;35:ex=01;32'
#export LSCOLORS=exfxcxdxbxegedabagacad
#alias ls='ls -G'
zstyle ':completion:*' list-colors 'di=34' 'ln=36' 'ex=32'
source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh

## keep background processes at full speed
#setopt NOBGNICE
## restart running processes on exit
#setopt HUP

## history
#setopt APPEND_HISTORY
## for sharing history between zsh processes
#setopt INC_APPEND_HISTORY
#setopt SHARE_HISTORY

## never ever beep ever
setopt NO_BEEP

## automatically decide when to page a list of completions
#LISTMAX=0

## disable mail checking
#MAILCHECK=0

#autoload -Uz colors
#colors

#PROMPT='%F{4}[%n@%m]%f %# %d 
#>>'
###RPROMPT='%/'
RPROMPT=''
###setopt transient_rprompt

export PATH="/usr/local/opt/llvm/bin:$PATH"
alias rsyncafi='(){rsync -ahv --progress -e "ssh -i ~/.ssh/id_rsa_ENa044_afifep" ENa044@afifep004:$1 $2}'

### added for pyenv environment
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PATH:$PYENV_ROOT/bin"
eval "$(pyenv init -)"
# . /Users/takakiba/.pyenv/versions/anaconda3-5.3.1/etc/profile.d/conda.sh  # commented out by conda initialize

bindkey -v

## added for showing vim mode
function zle-line-init zle-keymap-select {
	case $KEYMAP in
		vicmd)
#		RPROMPT='NOR'
		PROMPT='%F{4}[%n@%m]%f %F{009}CMD%f %# %d 
>>'
		;;
		main|vins)
#		RPROMPT='INS'
		PROMPT='%F{4}[%n@%m]%f %F{011}INS%f %# %d 
>>'
		;;
	esac
	zle reset-prompt
}
zle -N zle-line-init
zle -N zle-keymap-select


if [ -x /usr/local/bin/gdircolors ]; then
	eval `gdircolors ~/.colourrc`
	alias ls='gls --color=auto'
fi
#
# gaussian variables
g16root="/Applications"
GAUSS_SCRDIR="/Users/takakiba/Scratch"
export g16root GAUSS_SCRDIR
. $g16root/g16/bsd/g16.profile
#
export GV_DIR=/Applications/gv
# 
# rsync alias
alias rsync='rsync -ahv --progress'



# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/opt/intel/intelpython3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/opt/intel/intelpython3/etc/profile.d/conda.sh" ]; then
        . "/opt/intel/intelpython3/etc/profile.d/conda.sh"
    else
        export PATH="/opt/intel/intelpython3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

export PATH="/usr/local/sbin:$PATH"
