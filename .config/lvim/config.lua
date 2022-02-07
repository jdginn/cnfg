-- Debug
P = function(v)
    print(vim.inspect(v))
end

-- general
lvim.format_on_save = false
lvim.lint_on_save = true
lvim.lsp.diagnostics.update_in_insert = false

-- keymappings [view all the defaults by pressing <leader>Lk]
lvim.leader = "space"
-- add your own keymapping
lvim.keys.normal_mode["<C-s>"] = ":w<cr>"


lvim.builtin.dashboard.active = true
lvim.builtin.terminal.active = true
lvim.builtin.notify.active = true
lvim.builtin.nvimtree.side = "left"
lvim.builtin.nvimtree.show_icons.git = 1

lvim.builtin.treesitter.ensure_installed = {
  "bash",
  "c",
  "cpp",
  "go",
  "json",
  "lua",
  "python",
  "rust",
  "yaml",
}

lvim.builtin.treesitter.highlight.enabled = true
lvim.builtin.treesitter.highlight.enabled = true

vim.api.nvim_command("set foldmethod=expr")
vim.api.nvim_command("set foldexpr=nvim_treesitter#foldexpr()")

-- Additional Plugins
lvim.plugins = {
  {"jdginn/gruvbox-flat.nvim"},
  {"tmhedberg/SimpylFold"},
  {"simrat39/rust-tools.nvim"},
  {"tpope/vim-fugitive"}
}

lvim.colorscheme = "gruvbox-flat"
vim.g.gruvbox_flat_style = "hard"

require('rust-tools').setup({})

-- SimpylFold configuration
-- Fold/unfold with tab instead of zo/zc
vim.api.nvim_set_keymap('n', '<tab>', 'za', {noremap = true})


-- rsync on command
function File_exists(name)
  local f=io.open(name, "r")
  if f ~=nil then io.close(f) return true else return false end
end

function Git_toplevel()
  local cmd = "git -C " .. vim.fn.shellescape(vim.fn.getcwd()) .. " rev-parse --show-toplevel"
  local res = vim.fn.system(cmd)
  -- if string.startswith(res, "fatal:") then res = nil end
  return string.gsub(res, '\n', '')
end

Project_config_file = Git_toplevel() .. "/project_config.lua"

if File_exists(Project_config_file) then
  Project_config = dofile(Project_config_file)
else
  Project_config = nil
end

function Rsync()
  if Project_config == nil then
    print("Cannot rsync because no project_config.lua was found")
    return
  end

  local project_root = Git_toplevel()
  local cmd = "rsync -r " .. vim.fn.shellescape(project_root) .. "/* " .. vim.fn.shellescape(Project_config.rsync_destination)
  print(cmd)
  vim.fn.system(cmd)
end

---- which_key bindings ----
-- rsync
lvim.builtin.which_key.mappings["r"] = {
  name = "Remote",
  r = { function() Rsync() end, "Rsync"}
}

-- git
lvim.builtin.which_key.mappings["g"].a = { "<cmd>lua require 'gitsigns'.stage_buffer()<cr>", "Stage Buffer" }

require('vim.lsp.log').set_format_func(vim.inspect)
-- generic LSP settings

-- ---@usage disable automatic installation of servers
-- lvim.lsp.automatic_servers_installation = false

-- ---@usage Select which servers should be configured manually. Requires `:LvimCacheRest` to take effect.
-- See the full default list `:lua print(vim.inspect(lvim.lsp.override))`
-- vim.list_extend(lvim.lsp.override, { "pyright" })

-- ---@usage setup a server -- see: https://www.lunarvim.org/languages/#overriding-the-default-configuration
-- local opts = {} -- check the lspconfig documentation for a list of all possible options
-- require("lvim.lsp.manager").setup("pylsp", opts)

-- -- you can set a custom on_attach function that will be used for all the language servers
-- -- See <https://github.com/neovim/nvim-lspconfig#keybindings-and-completion>
-- lvim.lsp.on_attach_callback = function(client, bufnr)
--   local function buf_set_option(...)
--     vim.api.nvim_buf_set_option(bufnr, ...)
--   end
--   --Enable completion triggered by <c-x><c-o>
--   buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")
-- end

-- -- set a formatter, this will override the language server formatting capabilities (if it exists)
-- local formatters = require "lvim.lsp.null-ls.formatters"
-- formatters.setup {
--   { command = "black", filetypes = { "python" } },
--   { command = "isort", filetypes = { "python" } },
--   {
--     -- each formatter accepts a list of options identical to https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTINS.md#Configuration
--     command = "prettier",
--     ---@usage arguments to pass to the formatter
--     -- these cannot contain whitespaces, options such as `--line-width 80` become either `{'--line-width', '80'}` or `{'--line-width=80'}`
--     extra_args = { "--print-with", "100" },
--     ---@usage specify which filetypes to enable. By default a providers will attach to all the filetypes it supports.
--     filetypes = { "typescript", "typescriptreact" },
--   },
-- }

-- -- set additional linters
-- local linters = require "lvim.lsp.null-ls.linters"
-- linters.setup {
--   { command = "flake8", filetypes = { "python" } },
--   {
--     -- each linter accepts a list of options identical to https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTINS.md#Configuration
--     command = "shellcheck",
--     ---@usage arguments to pass to the formatter
--     -- these cannot contain whitespaces, options such as `--line-width 80` become either `{'--line-width', '80'}` or `{'--line-width=80'}`
--     extra_args = { "--severity", "warning" },
--   },
--   {
--     command = "codespell",
--     ---@usage specify which filetypes to enable. By default a providers will attach to all the filetypes it supports.
--     filetypes = { "javascript", "python" },
--   },
-- }
