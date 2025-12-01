#!/bin/bash

set -e

PKGS=(
    'base-devel'
    'git'
    'neovim'
    'emacs'
    'go'
    'zsh'
    'alacritty'
    'firefox'
    'curl'
    'ripgrep'
    'fd'
    'htop'
    'unzip'
    'inotify-tools'
    'obsidian'
    'xclip'
    'code'
    'vulkan-radeon'
    'lib32-vulkan-radeon'
    'steam'
    'tmux'
    'tree'
    'jq'
    'docker'
    'docker-compose'
)

msg() {
    echo -e "\n\e[1;32m[INFO]\e[0m $1"
}

# UPDATE SYSTEM & INSTALL PACMAN PACKAGES
msg "Updating system and installing essential packages..."
sudo pacman -Syu --noconfirm
sudo pacman -S --noconfirm --needed "${PKGS[@]}"

# INSTALL AUR HELPER (yay)
if ! command -v yay &> /dev/null; then
    msg "AUR helper 'yay' not found. Installing now..."
    cd /tmp
    git clone https://aur.archlinux.org/yay.git
    cd yay
    makepkg -si --noconfirm
    cd "$HOME"
else
    msg "'yay' is already installed. Skipping."
fi

# INSTALL WEB DEVELOPMENT TOOLING
msg "Installing web development environment (nvm, node, pnpm, yarn, bun)..."

# Install nvm
if [ ! -d "$HOME/.nvm" ]; then
    msg "Installing nvm..."
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash
else
    msg "nvm is already installed. Skipping installation."
fi

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

# Install Node.js LTS and global packages if Node is not found
if ! command -v node &> /dev/null; then
    msg "Installing latest Node.js LTS version..."
    nvm install --lts
    nvm use --lts
    nvm alias default 'lts/*'
    
    msg "Node.js installed. Now installing global packages pnpm and yarn..."
    npm install -g pnpm yarn
else
    msg "Node.js is already installed. Skipping installation of Node and global packages."
fi

# Install Bun
if [ ! -f "$HOME/.bun/bin/bun" ]; then
    msg "Installing Bun..."
    curl -fsSL https://bun.sh/install | bash
else
    msg "Bun is already installed. Skipping installation."
fi

# INSTALL AND CONFIGURE OH MY ZSH
if [ ! -d "$HOME/.oh-my-zsh" ]; then
    msg "Installing Oh My Zsh..."
    export CHSH=no; export RUNZSH=no; sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
else
    msg "Oh My Zsh is already installed. Skipping."
fi

if [ "$SHELL" != "/bin/zsh" ]; then
    msg "Changing default shell to zsh. You will need to enter your password."
    chsh -s $(which zsh)
fi

# Configure Docker
msg "Configuring Docker..."
sudo usermod -aG docker $USER
msg "User $USER added to 'docker' group."
sudo systemctl enable docker.service
msg "Docker service enabled."
sudo systemctl start docker.service
msg "Docker service started."

msg "The following packages were installed or verified via pacman:"
for pkg in "${PKGS[@]}"; do
    VERSION=$(echo "$INFO" | grep '^Version' | awk '{print $3}')
    INFO=$(pacman -Qi "$pkg")
    DESCRIPTION=$(echo "$INFO" | grep '^Description' | sed 's/Description\s*:\s*//')
    printf "  - %-15s (%s): %s\n" "$pkg" "$VERSION" "$DESCRIPTION"
done

echo -e "------------------------------------------------------------------\n
Installation complete!\n
Web development tools are installed.\n
\e[1;33m[IMPORTANT]\e[0m You MUST close and reopen your terminal for all\n
changes to take effect.\n
------------------------------------------------------------------"
