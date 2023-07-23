#shaka epic zsh config

#----------theme------------
# Enable colors and change prompt:
autoload -U colors && colors	# Load colors
PS1="%B%{$fg[red]%}<%{$fg[green]%}%n%{$fg[yellow]%}@%{$fg[blue]%}%M %{$fg[magenta]%}%~%{$fg[red]%}>%{$reset_color%}$%b "
setopt autocd		# Automatically cd into typed directory.
#stty stop undef		# Disable ctrl-s to freeze terminal.
setopt interactive_comments

autoload -U promptinit && promptinit					# autoload prompt
#Enable git on the right side
autoload -Uz vcs_info
precmd_vcs_info() { vcs_info }
precmd_functions+=( precmd_vcs_info )
setopt prompt_subst
RPROMPT=\$vcs_info_msg_0_
zstyle ':vcs_info:git:*' formats '%F{yellow}(%b)%f'
zstyle ':vcs_info:*' enable git

# History:
setopt APPEND_HISTORY # adds history
#setopt CORRECT
#setopt COMPLETE_IN_WORD
#setopt INC_APPEND_HISTORY SHARE_HISTORY  # adds history incrementally and share it across sessions
setopt SHARE_HISTORY  # acc. to man zshoptions INC_APPEND_HISTORY should be turned off, if this is on
setopt HIST_IGNORE_ALL_DUPS  # don't record dupes in history
setopt EXTENDED_HISTORY # add timestamps to history
HISTSIZE=100000
SAVEHIST=100000
HISTFILE=~/.config/zsh/history 

# Compile the completion dump to increase startup speed.
#zcompdump=~/.config/zsh/.zcompdump
#if [[ "$zcompdump" -nt "${zcompdump}.zwc" || ! -s "${zcompdump}.zwc" ]]; then
#zcompile "$zcompdump"
#fi

# Load aliases and shortcuts if existent.
[ -f "${XDG_CONFIG_HOME:-$HOME/.config}/zsh/aliasrc" ] && source "${XDG_CONFIG_HOME:-$HOME/.config}/zsh/aliasrc"

# Basic auto/tab complete:
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS} #add colors in tab completion
zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}'  'r:|=*' 'l:|=* r:|=*' #case insensitive tab completion

#Speed up zsh compinit :- https://gist.github.com/ctechols/ca1035271ad134841284
#autoload -Uz compinit && compinit
autoload -Uz compinit
for dump in ~/.config/zsh/zcompdump(N.mh+24); do
  compinit
done
compinit -C

zmodload zsh/complist
_comp_options+=(globdots)		# Include hidden files.


# vi mode
bindkey -v
export KEYTIMEOUT=1

autoload -U history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey '^R' history-incremental-search-backward
bindkey '^S' history-incremental-search-forward
bindkey '^D' delete-char-or-list
bindkey "^N" history-beginning-search-forward-end
bindkey "^P" history-beginning-search-backward-end 
bindkey "^B" backward-char
bindkey "^F" forward-char
bindkey "^a" beginning-of-line
bindkey "^e" end-of-line
bindkey "^[[1;5C" forward-word
bindkey "^[[1;5D" backward-word
# Use vim keys in tab complete menu:
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -v '^?' backward-delete-char

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

#cd into directory with fzf epic
bindkey -s '^f' 'cd "$(dirname "$(fzf)")"\n'

#https://github.com/ohmyzsh/ohmyzsh/issues/3440
#no longer need to reload shell after installing a package
zstyle ':completion:*' rehash true

# Edit line in vim with ctrl-t:
autoload edit-command-line; zle -N edit-command-line
bindkey '^t' edit-command-line

# Load syntax highlighting; should be last.
#source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh 2> /dev/null
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh 2> /dev/null
