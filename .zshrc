####### - generic configuration - #########
export INPUTRC=~/.inputrc

export PATH=/opt/homebrew/bin:/usr/bin:/bin:~/.local/bin:/usr/local/bin:/usr/local/go/bin:/Users/justinginn/go/bin:/usr/local/share/dotnet:~/.odin:/Users/justinginn/.cargo/bin

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

function zrc {
    vim ~/.zshrc
    zshrc
}

function basha {
	vim ~/.bashrc_aliases
	bash
}

# history setup
setopt SHARE_HISTORY
HISTFILE=$HOME/.zhistory
SAVEHIST=1000
HISTSIZE=999
setopt HIST_EXPIRE_DUPS_FIRST

# autocompletion using arrow keys (based on history)
bindkey '\e[A' history-search-backward
bindkey '\e[B' history-search-forward

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
PS1='%F{blue}%n@%m%f %F{green}%/%f $ '

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

###################################

####### LLM stuff ########

# Autocomplete server for nvim
function start_autocomplete_server {
  llama-server --model /Users/justinginn/Library/Caches/llama.cpp/ggml-org_Qwen2.5-Coder-3B-Q8_0-GGUF_qwen2.5-coder-3b-q8_0.gguf --port 8012 -ngl 99 -fa -ub 1024 -b 1024 -dt 0.1 --ctx-size 0 --cache-reuse 256
  # llama-server --fim-qwen-3b-default
}

#. "$HOME/.cargo/env"


# BEGIN opam configuration
# This is useful if you're using opam as it adds:
#   - the correct directories to the PATH
#   - auto-completion for the opam binary
# This section can be safely removed at any time if needed.
[[ ! -r '/Users/justinginn/.opam/opam-init/init.zsh' ]] || source '/Users/justinginn/.opam/opam-init/init.zsh' > /dev/null 2> /dev/null
# END opam configuration
