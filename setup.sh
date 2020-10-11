# Set upstream for config repo
cd $HOME
config branch --set-upstream-to origin master

# Install VimPlug
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

# Install all vim plugins in .vimrc and nvim/init.vim
vim +'PlugInstall --sync' +qa
nvim +'PlugInstall --sync' +qa
