####### - generic configuration - #########
export INPUTRC=~/.inputrc

# Suppress nagging message in macos
export BASH_SILENCE_DEPRECATION_WARNING=1

#TODO: this should really be host-specific
export PATH=$PATH:~/Library/Python/3.7/bin:/usr/local/bin

# vi mode for all bash functionality
set -o vi
export EDITOR=vim

######## - basic niceities - ########

# Open last-edited file
function ol {
	vim "$(ls -t | head -n1)"
}

# cd to last-edited directory
function cl {
	cd "$(ls -t | head -n1)"
}

function bashrc {
	vim ~/.bashrc
	bash
}


# setup arrow keys to work with emacs line editor in ksh
alias __A=
alias __B=
alias __C=
alias __D=
alias __H=

###################################

######## - text editors - ######## 

function vimrc { vim ~/.vimrc
}

function ni { nvim ~/.config/nvim/init.vim
}

###################################

######## - git magic - ######## 

function gitconfig { vim ~/.gitconfig
}

function gitl {
git log --pretty="format:%at %C(yellow)commit %H%Creset\nAuthor: %an <%ae>\nDate: %aD\n\n %s\n" | sort -r | cut -d" " -f2- | sed -e "s/\\\n/\\`echo -e '\n\r'`/g" | tr -d '\15\32' | less -R
}

function branch_recent {
for branch in `git branch | grep -v HEAD`;do echo -e `git show --format="%ci %cr" $branch | head -n 1` \\t$branch; done | sort -r
}

umask 0000
###################################

# fzf magic
[ -f ~/.fzf.bash ] && source ~/.fzf.bash

# source host-specific aliases
if [ -f $HOME/.bashrc_aliases ]; then
    . $HOME/.bashrc_aliases
fi

# Special config repo storing dotfiles
# Called with 'config' instead of 'git'
alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'
