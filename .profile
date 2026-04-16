export EDITOR=nvim
export BROWSER=librewolf
export TERM=foot
export TERMINAL=foot
export ELECTRON_OZONE_PLATFORM_HINT=auto
export XDG_SESSION_TYPE=wayland
export QT_QPA_PLATFORMTHEME=qt6ct
export QT_WAYLAND_DISABLE_WINDOWDECORATION=1
# Install qt5-wayland and qt6-wayland
export QT_QPA_PLATFORM=wayland
# Install adw-gtk-dark
export GTK_THEME=adw-gtk3-dark
# Install intel-media-driver
export LIBVA_DRIVER_NAME=iHD
# fix java applications weird font anti aliasing
# https://wiki.archlinux.org/title/Java#Tips_and_tricks
export JDK_JAVA_OPTIONS="-Dawt.useSystemAAFontSettings=on -Dswing.aatext=true -Dswing.defaultlaf=com.sun.java.swing.plaf.gtk.GTKLookAndFeel"
export _JAVA_AWT_WM_NONREPARENTING=1
# Format man pages
export MANROFFOPT="-c"
export MANPAGER="nvim +Man!"
export PAGER="bat"
# Fcitx (IME)
export XMODIFIERS=@im=fcitx
export QT_IM_MODULES="wayland;fcitx;ibus"
export QT_IM_MODULE=fcitx
export GTK_IM_MODULE=
