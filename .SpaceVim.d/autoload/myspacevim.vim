
" Jenkinsfile
autocmd BufRead,BufNewFile Jenkinsfile set ft=groovy
autocmd BufRead,BufNewFile Jenkinsfile* setf groovy
autocmd BufRead,BufNewFile *.jenkinsfile set ft=Jenkinsfile
autocmd BufRead,BufNewFile *.jenkinsfile setf groovy
autocmd BufRead,BufNewFile *.Jenkinsfile setf groovy

" YAML
"Get the 2-space YAML as the default when hit carriage return after the colon
autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab

function! myspacevim#before() abort
    " Shorten time between pressing space and the hint buffer appearing
    set timeoutlen=150
    " Make jumping between splits easier
    nnoremap <C-J> <C-W><C-J>
    nnoremap <C-K> <C-W><C-K>
    nnoremap <C-L> <C-W><C-L>
    nnoremap <C-H> <C-W><C-H>
    nnoremap <tab> za
    " Make the clipboard work
    set clipboard+=unnamed
    " guideline for how long a line should be
    set colorcolumn=100
    highlight ColorColumn ctermbg=DarkGrey ctermfg=white
    " Disable backward compatibility with vi
    set nocompatible
    " Enable plugins
    filetype plugin on
    let g:spacevim_relativenumber = 0
endfunction

function! myspacevim#after() abort
    let g:spacevim_relativenumber = 0
endfunction
