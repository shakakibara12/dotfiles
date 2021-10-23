export PATH="${PATH}:/home/shaka/bin:/home/shaka/.local/bin"
export LIBVA_DRIVER_NAME=i965
export VDPAU_DRIVER=va_gl
export ZDOTDIR=$HOME/.config/zsh
export EDITOR='nvim'
export TERMINAL='alacritty'
export MANPAGER='nvim +Man!'

if [ "$(tty)" = "/dev/tty1" ]; then
	exec sway
fi
export QT_QPA_PLATFORMTHEME=qt5ct
export LANG=en_IN.UTF-8
export XDG_CONFIG_HOME=$HOME/.config
