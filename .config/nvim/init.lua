vim.cmd 'packadd paq-nvim'            -- load package
local paq = require('paq-nvim').paq   -- import module with `paq` function

-- Manage plugins with Paq
require 'paq' {
    'savq/paq-nvim';                  -- Let Paq manage itself

    'Murtaza-Udaipurwala/gruvqueen';  -- Lua version of gruvbox
    'hoob3rt/lualine.nvim';           -- Statusline
}

