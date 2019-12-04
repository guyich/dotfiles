# This is the reload script for i3
# it generates a new config a nd then reload i3

echo > ~/.config/i3/config && 
for f in $HOME/.config/i3/*.i3; do (cat "${f}"; echo) >> ~/.config/i3/config; done &&
echo > ~/.config/polybar/config &&
#for f in $HOME/.dotfiles/**/*.polybar; do (cat "${f}"; echo) >> ~/.config/polybar/config; done &&
i3-msg restart