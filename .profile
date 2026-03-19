export BROWSER=librewolf
export ELECTRON_OZONE_PLATFORM_HINT="auto"
export XDG_SESSION_TYPE="wayland"
export TERM=foot
export QT_QPA_PLATFORMTHEME="qt5ct"
export GTK_THEME=adw-gtk3-dark
export LIBVA_DRIVER_NAME='iHD'
export _JAVA_AWT_WM_NONREPARENTING=1
# fix java applications weird font anti aliasing
# https://wiki.archlinux.org/title/java
export JDK_JAVA_OPTIONS='-Dawt.useSystemAAFontSettings=on -Dswing.aatext=true -Dswing.defaultlaf=com.sun.java.swing.plaf.gtk.GTKLookAndFeel'
export QT_WAYLAND_DISABLE_WINDOWDECORATION="1"
export QT_QPA_PLATFORM=wayland
export XDG_SCREENSHOTS_DIR=$HOME/Pictures/Screenshots
export XDG_CACHE_HOME=$HOME/.cache
# removes window outlines and stuff
export ZDOTDIR=$HOME/.config/zsh
export EDITOR='nvim'
export TERMINAL='foot'
# Exported through fish config
# export MANPAGER='nvim +Man!'
# export PAGER='bat'
export HISTCONTROL=erasedups,ignorespace
# not setting here instead set using localectl
# export LANG=en_US.UTF-8
export XDG_CONFIG_DIR=$HOME/.config
export NODE_PATH=$HOME/.config
export QT_IM_MODULES="wayland;fcitx;ibus"
export XMODIFIERS=@im=fcitx
export QT_IM_MODULE=fcitx
export GTK_IM_MODULE=
