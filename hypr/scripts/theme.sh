#!/usr/bin/env  bash



gnome_schema="org.gnome.desktop.interface"

gsettings set ${gnome_schema} gtk-theme 'adw-gtk3-dark'
gsettings set ${gnome_schema} icon-theme 'Adwaita'
gsettings set ${gnome_schema} cursor-theme 'Adwaita'
gsettings set ${gnome_schema} font-name 'Roboto 13'
gsettings set ${gnome_schema} document-font-name 'Roboto 13'
gsettings set ${gnome_schema} monospace-font-name 'Roboto 13'
gsettings set ${gnome_schema} color-scheme prefer-dark
gsettings set ${gnome_schema} enable-animations true
gsettings set org.gnome.desktop.wm.preferences button-layout "" 
