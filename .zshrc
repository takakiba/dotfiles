#
# .zshrc is sourced in interactive shells.
# It should contain commands to set up aliases,
# functions, options, key bindings, etc.
#

autoload -U compinit
compinit

#allow tab completion in the middle of a word
setopt COMPLETE_IN_WORD

if [ -x /usr/local/bin/gdircolors ]; then
	eval `gdircolors ~/.colourrc`
	alias ls='gls --color=auto'
fi

zstyle ':completion:*' list-colors 'di=34' 'ln=36' 'ex=32'
source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh

## never ever beep ever
setopt NO_BEEP

bindkey -v

## added for showing vim mode
function zle-line-init zle-keymap-select {
	case $KEYMAP in
		vicmd)
		PROMPT='%F{4}[%n@%m]%f %F{009}CMD%f %# %d 
>>'
		;;
		main|vins)
		PROMPT='%F{4}[%n@%m]%f %F{011}INS%f %# %d 
>>'
		;;
	esac
	zle reset-prompt
}
zle -N zle-line-init
zle -N zle-keymap-select

alias rsync='rsync -ahv --progress'
if [ -e ${HOME}/zshrc_dev ]; then
    source ${HOME}/zshrc_dev
fi

