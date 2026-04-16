## Set values
set -U fish_greeting

# Set settings for https://github.com/franciscolourenco/done
set -U __done_min_cmd_duration 10000
set -U __done_notification_urgency_level low

## Environment setup
# Apply .profile: use this to put fish compatible .profile stuff in
if test -f ~/.profile
  source ~/.profile
end

# Add to PATH
fish_add_path --path ~/.local/bin
fish_add_path --path ~/.cargo/bin

## Custom key bindings
function fish_user_key_bindings
    # Bind Ctrl+T to edit the command buffer
    bind \ct edit_command_buffer
end

## Functions
# Fish command history
function history
    builtin history --show-time='%F %T '
end

function ex
    if test -f $argv[1]
        switch $argv[1]
            case '*.tar.bz2'
                tar xvjf $argv[1]
            case '*.tar.gz'
                tar xvzf $argv[1]
            case '*.bz2'
                bunzip2 -v $argv[1]
            case '*.rar'
                unrar x -v $argv[1]
            case '*.gz'
                gunzip -v $argv[1]
            case '*.tar'
                tar xvf $argv[1]
            case '*.tbz2'
                tar xvjf $argv[1]
            case '*.tgz'
                tar xvzf $argv[1]
            case '*.zip'
                unzip -v $argv[1]
            case '*.Z'
                uncompress $argv[1]
            case '*.7z'
                7z x $argv[1]
            case '*.deb'
                ar x $argv[1]
            case '*.tar.xz'
                tar xvf $argv[1]
            case '*'
                echo "'$argv[1]' cannot be extracted via ex()"
        end
    else
        echo "'$argv[1]' is not a valid file"
    end
end


## Useful aliases
# Replace ls with eza
alias ls='eza -al --color=always --group-directories-first --icons' # preferred listing
alias la='eza -a --color=always --group-directories-first --icons'  # all files and dirs
alias ll='eza -l --color=always --group-directories-first --icons'  # long format
alias lt='eza -aT --color=always --group-directories-first --icons' # tree listing
alias l.="eza -a | grep -e '^\.'"                                     # show only dotfiles

# Common use
alias update-grub="sudo grub-mkconfig -o /boot/grub/grub.cfg"
alias fixpacman="sudo rm /var/lib/pacman/db.lck"
alias tarnow='tar -acf '
alias untar='tar -zxvf '
alias wget='wget -c '
alias psmem='ps auxf | sort -nr -k 4'
alias psmem10='ps auxf | sort -nr -k 4 | head -10'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias ......='cd ../../../../..'
alias dir='dir --color=auto'
alias vdir='vdir --color=auto'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
alias hw='hwinfo --short'                                   # Hardware Info
alias big="expac -H M '%m\t%n' | sort -h | nl"              # Sort installed packages according to size in MB
alias gitpkg='pacman -Q | grep -i "\-git" | wc -l'          # List amount of -git packages
alias update='sudo pacman -Syu'
alias ins='sudo pacman -Sy'
alias v='nvim'
alias rsync='rsync -vh'
alias cp='cp -v'

# Please don't curse me
alias lf='yazi'

# Readable output
alias df='df -h'

# List recently changed files < 24H
alias recent='find . -mtime 0'

# Free
alias free="free -mt"

# Continue wget downloads
alias wget="wget -c"

# Sussy baka
alias sus="systemctl suspend"

# Color always for diff
alias diff='diff --color=always'

# Cleanup orphaned packages
alias cleanup='sudo pacman -Rns (pacman -Qtdq)'

# Get the error messages from journalctl
alias jctl="journalctl -p 3 -xb"

# lpu_net
alias connect='bash ~/scripts/lpu_net.sh login'
alias disconnect='bash ~/scripts/lpu_net.sh logout'

# Recent installed packages
alias rip="expac --timefmt='%Y-%m-%d %T' '%l\t%n %v' | sort | tail -200 | nl"
