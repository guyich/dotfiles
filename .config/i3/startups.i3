# polybar
exec_always --no-startup-id $HOME/.config/polybar/launch.sh

# run with reload
exec_always --no-startup-id xrdb -load ~/.Xresources

# run once
exec --no-startup-id xfsettingsd

# needed for super to launch rofi through ksuperkey, see ~/.xprofile
bindsym Mod1+F1 exec --no-startup-id rofi_run -r