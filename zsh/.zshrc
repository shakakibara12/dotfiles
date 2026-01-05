# Shaka's epic zsh config
# Author: Shakakibara

#----------Theme------------
# Enable colors and change prompt:
autoload -U colors && colors
# Autoload prompt
autoload -U promptinit && promptinit
PS1="%B%{$fg[red]%}<%{$fg[green]%}%n%{$fg[yellow]%}@%{$fg[blue]%}%M %{$fg[magenta]%}%~%{$fg[red]%}>%{$reset_color%}$%b "
# Automatically cd into typed directory.
setopt autocd
setopt interactive_comments

# Enable git on the right side
autoload -Uz vcs_info
precmd_vcs_info() { vcs_info }
precmd_functions+=( precmd_vcs_info )
setopt prompt_subst
RPROMPT=\$vcs_info_msg_0_
zstyle ':vcs_info:git:*' formats '%F{yellow}(%b)%f'
zstyle ':vcs_info:*' enable git

# History:
setopt APPEND_HISTORY # adds history
setopt CORRECT
#setopt COMPLETE_IN_WORD
#setopt INC_APPEND_HISTORY SHARE_HISTORY  # adds history incrementally and share it across sessions
setopt HIST_IGNORE_SPACE #if command started with a space, it will not get added to history.
setopt SHARE_HISTORY  # acc. to man zshoptions INC_APPEND_HISTORY should be turned off, if this is on
#setopt HIST_IGNORE_ALL_DUPS  # don't record dupes in history
setopt HIST_IGNORE_DUPS # don't record dupes in history
setopt EXTENDED_HISTORY # add timestamps to history
HISTSIZE=1000000
SAVEHIST=1000000
HISTFILE=~/.config/zsh/history

# Load aliases and shortcuts if existent.
[ -f "${XDG_CONFIG_HOME:-$HOME/.config}/zsh/aliasrc" ] && source "${XDG_CONFIG_HOME:-$HOME/.config}/zsh/aliasrc"

# emit OSC 7 for foot to spawn new window in same directory.
function osc7-pwd() {
    emulate -L zsh # also sets localoptions for us
    setopt extendedglob
    local LC_ALL=C
    printf '\e]7;file://%s%s\e\' $HOST ${PWD//(#m)([^@-Za-z&-;_~])/%${(l:2::0:)$(([##16]#MATCH))}}
}

function chpwd-osc7-pwd() {
    (( ZSH_SUBSHELL )) || osc7-pwd
}
add-zsh-hook -Uz chpwd chpwd-osc7-pwd

# Speed up zsh compinit :- https://gist.github.com/ctechols/ca1035271ad134841284
autoload -Uz compinit

if [[ -n ${ZDOTDIR}/.zcompdump(#qN.mh+24) ]]; then
	compinit;
else
	compinit -C;
fi;

zmodload zsh/complist
_comp_options+=(globdots)		# Include hidden files.
# Basic auto/tab complete:
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS} #add colors in tab completion
zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}'  'r:|=*' 'l:|=* r:|=*' #case insensitive tab completion
zstyle ':completion:*' menu select
# fpath=(/usr/share/zsh/site-functions $fpath)


autoload -U history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
# Search backwards and forwards with a pattern
bindkey -M vicmd '/' history-incremental-pattern-search-backward
bindkey -M vicmd '?' history-incremental-pattern-search-forward

# Set up for insert mode too
bindkey -M viins '^R' history-incremental-pattern-search-backward
bindkey -M viins '^F' history-incremental-pattern-search-forward
bindkey '^D' delete-char-or-list
bindkey '^k' kill-line
bindkey "^N" history-beginning-search-forward-end
bindkey "^P" history-beginning-search-backward-end
bindkey "^B" backward-char
# Allow backspace to clear newline.
bindkey '^?' backward-delete-char
# bindkey "^F" forward-char
bindkey "^a" beginning-of-line
bindkey "^e" end-of-line
bindkey "^[[1;5C" forward-word
bindkey "^[[1;5D" backward-word
bindkey "\e[27;2;13~" accept-line  # shift+return
bindkey "\e[27;5;13~" accept-line  # ctrl+return

# Use vim keys in tab complete menu:
# vi mode
bindkey -v
export KEYTIMEOUT=1
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history
# bindkey -v '^?' backward-delete-char

# Change cursor shape for different vi modes.
function zle-keymap-select () {
    case $KEYMAP in
        vicmd) echo -ne '\e[1 q';;      # block
        viins|main) echo -ne '\e[5 q';; # beam
    esac
}
zle -N zle-keymap-select
echo -ne '\e[5 q' # Use beam shape cursor on startup.
preexec() { echo -ne '\e[5 q' ;} # Use beam shape cursor for each new prompt.

# cd into directory with fzf epic
# bindkey -s '^f' 'cd "$(dirname "$(fzf)")"\n'

# emit an OSC-133;A sequence before each prompt.
# https://codeberg.org/dnkl/foot/wiki#user-content-jumping-between-prompts
precmd() {
    print -Pn "\e]133;A\e\\"
}

# https://github.com/ohmyzsh/ohmyzsh/issues/3440
# Avoid reloading after installing a package.
zstyle ':completion:*' rehash true

# Edit line in vim with ctrl-t:
autoload edit-command-line
zle -N edit-command-line
bindkey '^t' edit-command-line

# Load syntax highlighting; should be last.
# source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh 2> /dev/null
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh 2> /dev/null
