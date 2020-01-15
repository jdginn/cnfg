####### - generic configuration - #########
export INPUTRC=~/.inputrc

# Suppress nagging message in macos
export BASH_SILENCE_DEPRECATION_WARNING=1

export PATH=$PATH:~/Library/Python/3.7/bin:/usr/local/bin

# vi mode for all bash functionality
set -o vi

######## - basic niceities - ########

function bashrc {
	vim ~/.bashrc
	bash
}

function vimrc { vim ~/.vimrc
}

function ol {
	vim "$(ls -t | head -n1)"
}

function cl {
	cd "$(ls -t | head -n1)"
}

######## - REAPER scipt paths #####
#export REAPER='/Users/justinginn/Library/Application\\ Support/REAPER'
function reaper { 
	cd /Users/justinginn/Library/Application\ Support/REAPER
}

######## - still needed? - ########
export pchar='
$ '
export me=`whoami`
export where=`uname -n`
export what=`uname -s`
export PS1='[$what:$0:$me@$where]$PWD $pchar'

alias bigvnc='vncserver -geometry 1600x900  '


# setup arrow keys to work with emacs line editor in ksh
alias __A=
alias __B=
alias __C=
alias __D=
alias __H=

###################################

umask 0000
echo "umask setting:"
umask

# Special config repo storing dotfiles
# Called with 'config' instead of 'git'
alias config='/usr/bin/git --git-dir=/Users/justinginn/.cfg/ --work-tree=/Users/justinginn'
