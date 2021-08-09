"-------- VimPlug config -----
call plug#begin()
"	Fancy colorsheme
"Plug 'morhetz/gruvbox'
Plug 'mhartington/oceanic-next'
"	Folding for methods and classes
"Plug 'tmhedberg/SimpylFold'
Plug 'Konfekt/FastFold'
"  Better auto-indentation for python
Plug 'vim-scripts/indentpython.vim'
""  Status bar
Plug 'vim-airline/vim-airline'
"  Close parenthesis/brackets
Plug 'Raimondi/delimitMate'
"  Highlight other occurances of this item
Plug 'RRethy/vim-illuminate'
"  Profile startup time
"Plug 'tweekmonster/startuptime.vim'
"  Git support
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
"  Better merge conflit resolution
Plug 'christoomey/vim-conflicted'

"  Linting
Plug 'w0rp/ale'

"  Code completion
Plug 'neoclide/coc.nvim', {'branch': 'release'}
"  Additional syntax support
Plug 'sheerun/vim-polyglot'

"  Better auto-indentation for python
Plug 'vim-scripts/indentpython.vim'
"  Alternate between source and headers in C/C++
Plug 'ton/vim-alternate'


"Plug 'neomake/neomake'

call plug#end()

"  ------- FastFold ---------
let g:python_fold = 1

"  ------- ALE options --------
"  ALE integration with airline
let g:airline#extensions#ale#enabled = 1

"  When to lint
let g:ale_lint_on_text_changed = 0
let g:ale_lint_on_insert_leave = 1
let g:ale_lint_on_enter = 0
let g:ale_lint_on_save = 1

"let g:ale_linters = {'python' : ['flake8', 'pycodestyle', 'pydocstyle']}
let g:ale_linters = {'python' : ['flake8']}


"  Prettier formatting
"let g:ale_echo_msg_error_str = 'E'
"let g:ale_echo_msg_warning_str = 'W'
"let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'
let g:ale_sign_error = '●'
let g:ale_sign_warning = '.'

let g:ale_completion_enabled = 1
let g:ale_python_flake8_options = '--config ~/.config/flake8'

"  Map ctrl+e to jump to next error
nmap <silent> <C-e> <Plug>(ale_next_wrap)
nmap <silent> <C-b> <Plug>(ale_previous_wrap)

"function! LinterStatus() abort
"    let l:counts = ale#statusline#Count(bufnr(''))    let l:all_errors = l:counts.error + l:counts.style_error
"    let l:all_non_errors = l:counts.total - l:all_errors    return l:counts.total == 0 ? 'OK' : printf(
"        \   '%d⨉ %d⚠ ',
"        \   all_non_errors,
"        \   all_errors
"        \)
"endfunction
"
"set statusline+=%=
"set statusline+=\ %{LinterStatus()}

"let g:coc_node_path = '/afs/apd.pok.ibm.com/u/jdginn/tarballs/node-v12.17.0-linux-x64/bin/node'
"let g:coc_node_path = '/afs/apd.pok.ibm.com/u/jdginn/.local/bin/node'
"let g:ale_lint_delay = 2000


"  ------- Misc config --------
"gruvbox configuration
"colorscheme gruvbox
"let g:gruvbox_contrast_dark = 'hard'
colorscheme OceanicNext
let g:airline_theme='oceanicnext'
set t_Co=256
syntax on

"line numbering by default
set nu

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
set colorcolumn=72,100
highlight ColorColumn ctermbg=DarkGrey ctermfg=white

"misc
set showmatch

"configuring flake8
let g:flake8_cmd="/afs/apd.pok.ibm.com/u/jdginn/.local/bin/flake8"
