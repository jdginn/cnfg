####### - generic configuration - #########
export INPUTRC=~/.inputrc

# Suppress nagging message in macos
export BASH_SILENCE_DEPRECATION_WARNING=1

# Command line
# export PS1="\u@\h:[\w]:\n$ "
export PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
#export PS1="[\w]:\n$ "

#TODO: this should really be host-specific
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

function bashrc {
	vim ~/.bashrc
    source ~/.bashrc	
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

function ni { nvim ~/.config/nvim/init.lua
}

function spacevim { nvim -u ~/.SpaceVim/vimrc
}

###################################

######## - git magic - ######## 
# Special config repo storing dotfiles
# Called with 'config' instead of 'git'
alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'

source ~/git-completion.bash

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

alias test_all_commits='git rebase -i origin/main --exec "git show $(more $(git rev-parse --git-path REBASE_HEAD)) --name-only; make check"'

# Use rsync to sync local contents to a remote clone
# Because rsync only copies diffs between files, it's the fastest way
function reposync {
    repo=$1
    remote=$2
    dest=$3
    startup=$4
    echo "Enter password"
    stty -echo
    read paswd
    stty echo
    # compress files, recursive copy, preserve symlinks, permissions, and timestamps \
    # exclude everything git is ignoring
    #echo $paswd > rsync -zirlptD --delete-after --exclude=.git \
    rsync -zirlptD --delete-after --exclude=.git \
        $(git -C $repo ls-files --exclude-standard -oi --directory | while read a; do echo -n \"--exclude=$a \"; done) \
        $repo $remote:$dest
}

# Update local clone to mtach a branch
function uh {
	if [ $PWD == $HOME ]; then
		cmd="config"
	else
		cmd="git"
	fi

	if [ -z $1 ]; then
		remote="origin"
	else
		remote=$1
	fi

	if [ -z $2 ]; then
		branch="master"
	else
		branch="$2"
	fi

	if [[ $(eval $cmd diff --stat) != '' ]]; then
		echo "Local changes will be overwritten - continue? y/n"
		read override
		if [[ $override != "y" && $override != "Y" ]]; then
			echo "Aborting"
			return
		fi
	fi

	echo "Upading local contents to match $remote/$branch"
	eval $cmd fetch
	eval $cmd reset --hard $remote/$branch
}

umask 0000
###################################

# fzf magic
[ -f ~/.fzf.bash ] && source ~/.fzf.bash

# source host-specific aliases
if [ -f $HOME/.bashrc_aliases ]; then
    . $HOME/.bashrc_aliases
fi

# added by travis gem
[ ! -s /Users/justinginn/.travis/travis.sh ] || source /Users/justinginn/.travis/travis.sh

#. "$HOME/.cargo/env"
