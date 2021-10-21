# Make it easy to point to config files included where this is cloned
export FLAWLESS_DIR=$(pwd)
echo $FLAWLESS_DIR
export LVBRANCH=flawless
set -o errexit

# Create a local bin directory
rm -rf $HOME/.local/share/lunarvim
rm -rf $HOME/.config/lvim

echo "Installing neovim..."
brew install neovim

# Install node.js (needed for language servers)
echo "Installing node.js..."
brew install node
brew link --overwrite node

# Install ripgrep
echo "Installing ripgrep..."
brew install ripgrep

# Install packer
echo "Installing packer..."
if [ -e "$HOME/.local/share/lunarvim/site/pack/packer/start/packer.nvim" ]; then
    echo 'packer already installed'
else
    git clone https://github.com/wbthomason/packer.nvim.git $HOME/.local/share/lunarvim/site/pack/packer/start/packer.nvim
fi

# Install lunarvim
echo "Cloning LunarVim configuration"
mkdir -p $HOME/.local/share/lunarvim
# Use my fork because we need some customizations that have not gone upstream
git clone --branch "$LVBRANCH" https://github.com/jdginn/LunarVim.git $HOME/.local/share/lunarvim/lvim
mkdir -p "$HOME/.config/lvim"
echo "Linking config files"
ln -s "$FLAWLESS_DIR/config/lvim/config.lua" "$HOME/.config/lvim/config.lua"
# Convenience wrapper that calls the right thing when requested
cp "$FLAWLESS_DIR/bin/lvim" "/usr/local/bin/"

echo "Installing the neovim plugin for node..."
npm -g install neovim
echo "Installing pyright..."
npm -g install pyright

echo "Installing linters..."
brew install pylint
brew install yapf

echo "Installing plugins using Packer"
nvim -u $HOME/.local/share/lunarvim/lvim/init.lua --cmd "set runtimepath+=$HOME/.local/share/lunarvim/lvim" --headless \
    +'autocmd User PackerComplete sleep 100m | qall' \
    +PackerInstall

echo "Syncing plugins using Packer"
nvim -u $HOME/.local/share/lunarvim/lvim/init.lua --cmd "set runtimepath+=$HOME/.local/share/lunarvim/lvim" --headless \
    +'autocmd User PackerComplete sleep 100m | qall' \
    +PackerSync

# Install mosh
echo "Installing mosh..."
brew install mosh --HEAD

printf "\nInstall Complete\n"
