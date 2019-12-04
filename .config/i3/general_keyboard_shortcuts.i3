# Basic Bindings
bindsym	$Mod+Return		    exec $term
bindsym $Mod+Shift+e 		exec prompt "Exit i3" "i3-msg exit"
bindsym Mod1+q			    [con_id="__focused__" instance="^(?!dropdown|pythonshell|conky-quickview|rangerdropdown).*$"] kill
bindsym $Mod+Shift+r		exec ~/.config/i3/reload.sh
bindsym $Mod+d			    exec rofi -show drun -padding 80 -bw 0 -lines 8 -width 100% -location 1 -show-icons 
bindsym $Mod+Shift+x		exec i3lock-fancy -n -p
bindsym $Mod+m			    move workspace to output left

# layout
# bindsym $Mod+s			    layout stacking
# bindsym $Mod+w			    layout tabbed
# bindsym	$Mod+e			    layout toggle split
bindsym $Mod+f			    fullscreen toggle
bindsym $Mod+v			    split toggle
bindsym $Mod+space 		    focus mode_toggle
bindsym $Mod+Shift+space	floating toggle

# change focus
bindsym $Mod+h 			    focus left
bindsym $Mod+j			    focus down
bindsym $Mod+k 			    focus up
bindsym $Mod+l		 	    focus right
bindsym $Mod+Left 		    focus left
bindsym $Mod+Down 		    focus down
bindsym $Mod+Up 		    focus up
bindsym $Mod+Right 		    focus right

# move focused window
bindsym $Mod+Shift+h 		move left
bindsym $Mod+Shift+j 		move down
bindsym $Mod+Shift+k 		move up
bindsym $Mod+Shift+l	 	move right
bindsym $Mod+Shift+Left 	move left
bindsym $Mod+Shift+Down 	move down
bindsym $Mod+Shift+Up 		move up
bindsym $Mod+Shift+Right 	move right

# floating move with mouse and $Mod
floating_modifier $Mod

# Media Controls
bindsym $Mod+F2             exec playerctl play-pause
bindsym $Mod+F1             exec playerctl previous
bindsym $Mod+F3             exec playerctl next
bindsym XF86AudioNext       exec playerctl next
bindsym XF86AudioPrev       exec playerctl previous
bindsym XF86AudioPlay       exec playerctl play-pause
bindsym XF86AudioStop       exec playerctl stop

# Gaps
bindsym $Mod+Mod1+plus      gaps inner current plus 5
bindsym $Mod+Mod1+minus     gaps inner current minus 5

bindsym $Mod+plus           gaps outer current plus 5
bindsym $Mod+minus          gaps outer current minus 5

bindsym $Mod+shift+plus     gaps inner current set 15; gaps outer current set 15
bindsym $Mod+shift+minus    gaps inner current set 0; gaps outer current set 0

# Volume
bindsym $Mod+F9                 exec pulsemixer --change-volume -5
bindsym $Mod+F10                exec pulsemixer --change-volume +5
bindsym XF86AudioRaiseVolume    exec pulsemixer --change-volume +5
bindsym XF86AudioLowerVolume    exec pulsemixer --change-volume -5
bindsym XF86AudioMute           exec pulsemixer --mute
