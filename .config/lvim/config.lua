-- Debug
P = function(v)
  print(vim.inspect(v))
end

-- general
lvim.format_on_save = false
lvim.lint_on_save = true
lvim.lsp.diagnostics.update_in_insert = false

-- fix copy-paste
vim.opt.mouse = ""

-- keymappings [view all the defaults by pressing <leader>Lk]
lvim.leader = "space"
-- add your own keymapping
lvim.keys.normal_mode["<C-s>"] = ":w<cr>"


lvim.builtin.alpha.active = true
lvim.builtin.terminal.active = true
lvim.builtin.notify.active = true

lvim.builtin.treesitter.ensure_installed = {
  "bash",
  "c",
  "cpp",
  "go",
  "json",
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
  { "jdginn/gruvbox-flat.nvim" },
  { "tmhedberg/SimpylFold" },
  { "simrat39/rust-tools.nvim" },
  { "buoto/gotests-vim" },
  { "puremourning/vimspector" },
  { 'lewis6991/spellsitter.nvim' },
  { "ray-x/go.nvim" },
  { "ray-x/guihua.lua" },
  { "ThePrimeagen/refactoring.nvim" },
  { "sindrets/diffview.nvim" },
}

lvim.colorscheme = "gruvbox-flat"
vim.g.gruvbox_flat_style = "hard"

require('rust-tools').setup({})

-- SimpylFold configuration
-- Fold/unfold with tab instead of zo/zc
vim.api.nvim_set_keymap('n', '<tab>', 'za', { noremap = true })


-- rsync on command
function File_exists(name)
  local f = io.open(name, "r")
  if f ~= nil then io.close(f) return true else return false end
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
  local cmd = "rsync -r " ..
      vim.fn.shellescape(project_root) .. "/* " .. vim.fn.shellescape(Project_config.rsync_destination)
  print(cmd)
  vim.fn.system(cmd)
end

lvim.builtin.which_key.mappings["R"] = {
  name = "Remote",
  r = { function() Rsync() end, "Rsync" }
}

-- go
require('go').setup({
  max_line_len = 110,
  gotests_template = "testify",
})
require('go.format').goimport()
lvim.builtin.which_key.mappings["o"] = {
  name = "Go",
  t = {
    p = { "<cmd> GoTestPkg -t testing <CR>", "Test package" },
    f = { "<cmd> GoTestFunc -t testing <CR>", "Test this function" },
    F = { "<cmd> GoTestFile -t testing <CR>", "Test this file" },
    a = { "<cmd> GoAddTest -template=testify<CR>", "Add test for this function" },
  },
  f = {
    s = { "<cmd> GoFillStruct <CR>", "Autofill struct" },
    w = { "<cmd> GoFillSwitch <CR>", "Autofill switch" },
  },
  c = { "<cmd> GoCoverage -t testing <CR>", "Show Coverage" },
  d = { "<cmd> GoDoc <CR>", "GoDoc" },
  l = { "<cmd> GoLint <CR>", "Lint" },
  o = { "<cmd> GoPkgOutline <CR>", "Package Outline" },
  i = { "<cmd> GoImport <CR>", "Organize Imports" },
  I = { "<cmd> GoImpl <CR>", "Implement Interface" },
  j = { "<cmd> GoAlt! <CR>", "Alternate test file" },
  e = { "<cmd> GoIfErr <CR>", "Add if err" },
}

-- refactoring
require("refactoring").setup({
  prompt_func_return_type = {
    go = true
  },
  prompt_func_param_type = {
    go = true
  },
})

vim.api.nvim_set_keymap("v", "re", [[ <Esc><Cmd>lua require('refactoring').refactor('Extract Function')<CR>]],
  { noremap = true, silent = true, expr = false })
vim.api.nvim_set_keymap("v", "rf",
  [[ <Esc><Cmd>lua require('refactoring').refactor('Extract Function To File')<CR>]],
  { noremap = true, silent = true, expr = false })
vim.api.nvim_set_keymap("v", "rv", [[ <Esc><Cmd>lua require('refactoring').refactor('Extract Variable')<CR>]],
  { noremap = true, silent = true, expr = false })
vim.api.nvim_set_keymap("v", "ri", [[ <Esc><Cmd>lua require('refactoring').refactor('Inline Variable')<CR>]],
  { noremap = true, silent = true, expr = false })

-- Extract block doesn't need visual mode
vim.api.nvim_set_keymap("n", "rb", [[ <Cmd>lua require('refactoring').refactor('Extract Block')<CR>]],
  { noremap = true, silent = true, expr = false })
vim.api.nvim_set_keymap("n", "rbf", [[ <Cmd>lua require('refactoring').refactor('Extract Block To File')<CR>]],
  { noremap = true, silent = true, expr = false })

-- Inline variable can also pick up the identifier currently under the cursor without visual mode
vim.api.nvim_set_keymap("n", "ri", [[ <Cmd>lua require('refactoring').refactor('Inline Variable')<CR>]],
  { noremap = true, silent = true, expr = false })

---- which_key bindings ----

-- git
lvim.builtin.which_key.mappings["g"] = {
  a = { "<cmd>lua require 'gitsigns'.stage_buffer()<cr>", "Stage Buffer" },
}
lvim.builtin.which_key.mappings["G"] = {
  name = "GitDiff",
  d = { "<cmd> DiffviewFileHistory <cr>", "Open Diffview" },
  c = { "<cmd> DiffviewClose <cr>", "Close Diffview" },
  f = { "<cmd> DiffviewToggleFiles <cr>", "Open Files toolbar" },
}

-- smart spellchecking with TreeSitter
require('spellsitter').setup {
  enable = { ".txt", ".md" }
}


-- guideline for how long a line should be
vim.api.nvim_exec('set colorcolumn=80', false)
vim.api.nvim_exec('highlight ColorColumn ctermbg=DarkGrey ctermfg=white', false)

require('vim.lsp.log').set_format_func(vim.inspect)
-- generic LSP settings

---@usage setup a server -- see: https://www.lunarvim.org/languages/#overriding-the-default-configuration
-- local opts = {filetypes = {"c", "cpp", "objc", "objcpp", ".cu", ".cuh", ".inl"}} -- check the lspconfig documentation for a list of all possible options
require("lvim.lsp.manager").setup("clangd", opts)
local opts = { filetypes = { "c", "cpp", "objc", "objcpp", "cuda" } } -- check the lspconfig documentation for a list of all possible options
