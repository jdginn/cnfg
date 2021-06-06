" Configuration for Vundle
set nocompatible              " required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" -------- list of vim plugins --------
"  Vundle must be added as a plugin
Plugin 'gmarik/Vundle.vim'
"  Fancy colorscheme
Plugin 'morhetz/gruvbox'
"  Support folding for methods and classes
Plugin 'tmhedberg/SimpylFold'
"  Better auto-indentation for python
Plugin 'vim-scripts/indentpython.vim'
"  Display file hierarchies
Plugin 'scrooloose/nerdtree'
"  Git integration
"Plugin 'tpope/vim-fugitive'
"  Status bar
Plugin 'vim-airline/vim-airline'
"  Close parenthesis/brackets
Plugin 'Raimondi/delimitMate'
"  Highlight other occurances of this item
Plugin 'RRethy/vim-illuminate'
"  Force myself to follow PEP 8
"Plugin 'nvie/vim-flake8'
"  Fancy comment blocks
" Plugin 'cometsong/commentframe.vim'
"  Quick commenting
Plugin 'scrooloose/nerdcommenter'

"  Syntax checker
"Plugin 'vim-syntastic/syntastic'
"
"  Python autocompletion -- doesn't work since current version of vim does not
"  support python3
"Plugin 'davidhalter/jedi-vim'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

"  ------- Misc config --------

"gruvbox configuration
colorscheme gruvbox
set background=dark
let g:gruvbox_contrast_dark = 'hard'
set t_Co=256
syntax on

"line numbering by default
set nu

"remap leader
let mapleader = ","

"generic tab behavior
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab

"fold with spacebar instead of za
nnoremap <space> za

"set up indentation for python
au BufNewFile, BufRead *.py
    \ set tabstop=4
    \ set softtabstop=4
    \ set shiftwidth=4
    \ set textwidth=79
    \ set expandtab
    \ set autoindent
    \ set fileformat=unix
    \ set encoding=utf-8
    "highlight python issues
    \ let python_highlight_all=1
    \ syntax on

"set up indentation for xml
au BufNewFile, BufRead *.xml
    \ set tabstop=2
    \ set softtabstop=2
    \ set shiftwidth=2
    \ set textwidth=79
    \ set expandtab
    \ set autoindent
    \ set fileformat=unix
    \ set encoding=utf-8
    "highlight python issues
    \ let python_highlight_all=1
    \ syntax on

"set up indentation for yaml
au BufNewFile, BufRead *.yaml
    \ set tabstop=2
    \ set softtabstop=2
    \ set shiftwidth=2
    \ set textwidth=79
    \ set expandtab
    \ set autoindent
    \ set fileformat=unix
    \ set encoding=utf-8
    "highlight python issues
    \ let python_highlight_all=1
    \ syntax on
"set up indentation for java
autocmd Filetype java setlocal tabstop=2 softtabstop=2 shiftwidth=2 expandtab autoindent

"flag bad whitespace
highlight BadWhitespace ctermbg=red guibg=red

"make jumping between splits easier
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

"guideline for how long a line should be
set colorcolumn=100
highlight ColorColumn ctermbg=DarkGrey ctermfg=white

"misc
set showmatch
set hlsearch

"configuring flake8
let g:flake8_cmd="/afs/apd.pok.ibm.com/u/jdginn/.local/bin/flake8"

"config for syntastic
"set statusline+=%#warningmsg#
"set statusline+=%{SyntasticStatuslineFlag()}
"set statusline+=%*
"
"let g:syntastic_always_populate_loc_list = 1
"let g:syntastic_auto_loc_list = 1
"let g:syntastic_check_on_open = 1
"let g:syntastic_check_on_wq = 0
