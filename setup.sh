cd $HOME

# Install Vundle
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim

# Install all vim plugins in .vimrc and nvim/init.vim
vim +'PlugInstall --sync' +qa
nvim +'PlugInstall --sync' +qa
