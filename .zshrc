####### - generic configuration - #########
export INPUTRC=~/.inputrc

export PATH=/usr/bin:/bin:~/.local/bin

# vi mode for all bash functionality
set -o vi
export EDITOR=vim

# Browser for when we want it
export BROWSER=firefox

######## - basic niceities - ########

# Open last-edited file
function ol {
	vim "$(ls -t | head -n1)"
}

# cd to last-edited directory
function cl {
	cd "$(ls -t | head -n1)"
}

function basha {
	vim ~/.bashrc_aliases
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

###################################

######## - git magic - ######## 
# Special config repo storing dotfiles
# Called with 'config' instead of 'git'
alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'

# Git completion
autoload -Uz compinit && compinit
# Prompt with version control info
autoload -Uz vcs_info
precmd () { vcs_info }
zstyle ':vcs_info:*' formats ' %s(%b)'

# PS1='%n@%m %F{red}%/%f$vcs_info_msg_0_ $ '
PS1='%n@%m %/ $ '

function gitconfig { vim ~/.gitconfig
}

function tc { vim ~/.tmux.conf
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

#. "$HOME/.cargo/env"
