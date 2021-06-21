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
endfunction

function! myspacevim#after() abort
    let g:spacevim_relativenumber = 0
    let g:netrw_silent = 0
endfunction
