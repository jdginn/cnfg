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
  { "simrat39/rust-tools.nvim" },
  { "tmhedberg/SimpylFold" },
  -- { "buoto/gotests-vim" },
  { 'lewis6991/spellsitter.nvim' },
  { "tpope/vim-fugitive" },
  { "ray-x/go.nvim" },
  { "ray-x/guihua.lua" },
  { "ThePrimeagen/refactoring.nvim" },
  { "sindrets/diffview.nvim" },
  { "akinsho/git-conflict.nvim", tag = "*" },
  { "rcarriga/nvim-dap-ui", tag = "*" },
  { "theHamsta/nvim-dap-virtual-text", tag = "*" },
}

-- Colorscheme
lvim.colorscheme = "gruvbox-flat"
vim.g.gruvbox_flat_style = "hard"

require('rust-tools').setup({})

-- SimpylFold configuration
-- Fold/unfold with tab instead of zo/zc
vim.api.nvim_set_keymap('n', '<tab>', 'za', { noremap = true })

-- DAP
lvim.builtin.dap.active = true
lvim.builtin.which_key.mappings["d"] = {
  name = "Debug",
  t = { "<cmd>lua require'dap'.toggle_breakpoint()<cr>", "Toggle Breakpoint" },
  b = { "<cmd>lua require'dap'.step_back()<cr>", "Step Back" },
  c = { "<cmd>lua require'dap'.continue()<cr>", "Continue" },
  C = { "<cmd>lua require'dap'.run_to_cursor()<cr>", "Run To Cursor" },
  d = { "<cmd>lua require'dap'.disconnect()<cr>", "Disconnect" },
  g = { "<cmd>lua require'dap'.session()<cr>", "Get Session" },
  i = { "<cmd>lua require'dap'.step_into()<cr>", "Step Into" },
  o = { "<cmd>lua require'dap'.step_over()<cr>", "Step Over" },
  u = { "<cmd>lua require'dap'.step_out()<cr>", "Step Out" },
  p = { "<cmd>lua require'dap'.pause()<cr>", "Pause" },
  r = { "<cmd>lua require'dap'.repl.toggle()<cr>", "Toggle Repl" },
  s = { "<cmd>lua require'dap'.continue()<cr>", "Start" },
  q = { "<cmd>lua require'dap'.close()<cr>", "Quit" },
}


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
  test_runner = "richgo",
  -- build_tags = "testing",
  run_in_floaterm = true,
  gotests_template = "testify",
  dap_debug = true,
  dap_debug_gui = true,
})
require('go.format').goimport()
lvim.builtin.which_key.mappings["o"] = {
  name = "Go",
  t = {
    name = "Test",
    p = { "<cmd> GoTestPkg -t testing <CR> --build-flags testing", "Test package" },
    f = { "<cmd> GoTestFunc -t testing <CR> --build-flags testing", "Test this function" },
    F = { "<cmd> GoTestFile -t testing --build-flags testing<CR>", "Test this file" },
    a = { "<cmd> GoAddTest -template=testify<CR>", "Add test for this function" },
    D = { "<cmd> lua _GO_NVIM_CFG.test_runner='dlv'<CR> ", "Switch to dlv" },
    R = { "<cmd> lua _GO_NVIM_CFG.test_runner='richgo'<CR> ", "Switch to richgo" },
    G = { "<cmd> lua _GO_NVIM_CFG.test_runner='gotesting'<CR> ", "Switch to vanilla go" },
  },
  d = {
    name = "Debug",
    l = { "<cmd> GoDebug <CR>", "Launch" },
    b = { "<cmd> GoBreakToggle <CR>", "Breakpoint" },
    B = { "<cmd> BreakCondition <CR>", "Break Condition" },
    r = { "<cmd> ReplToggle <CR>", "Toggle Repl" },
    -- s = { "<cmd> GoDbgStep <CR>", "Step" },
    -- c = { "<cmd> GoDbgContinue <CR>", "Continue" },
    q = { "<cmd> GoDbgStop <CR>", "Stop" },
    k = { "<cmd> GoDbgKeys <CR>", "Show Map" },
  },
  f = {
    name = "fill",
    s = { "<cmd> GoFillStruct <CR>", "Autofill struct" },
    w = { "<cmd> GoFillSwitch <CR>", "Autofill switch" },
  },
  c = { "<cmd> GoCoverage -t testing <CR>", "Show Coverage" },
  D = { "<cmd> GoDoc <CR>", "GoDoc" },
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

-- vim.api.nvim_set_keymap("v", "re", [[ <Esc><Cmd>lua require('refactoring').refactor('Extract Function')<CR>]],
--   { noremap = true, silent = true, expr = false })
-- vim.api.nvim_set_keymap("v", "rf",
--   [[ <Esc><Cmd>lua require('refactoring').refactor('Extract Function To File')<CR>]],
--   { noremap = true, silent = true, expr = false })
-- vim.api.nvim_set_keymap("v", "rv", [[ <Esc><Cmd>lua require('refactoring').refactor('Extract Variable')<CR>]],
--   { noremap = true, silent = true, expr = false })
-- vim.api.nvim_set_keymap("v", "ri", [[ <Esc><Cmd>lua require('refactoring').refactor('Inline Variable')<CR>]],
--   { noremap = true, silent = true, expr = false })

-- -- Extract block doesn't need visual mode
-- vim.api.nvim_set_keymap("n", "rb", [[ <Cmd>lua require('refactoring').refactor('Extract Block')<CR>]],
--   { noremap = true, silent = true, expr = false })
-- vim.api.nvim_set_keymap("n", "rbf", [[ <Cmd>lua require('refactoring').refactor('Extract Block To File')<CR>]],
--   { noremap = true, silent = true, expr = false })

-- -- Inline variable can also pick up the identifier currently under the cursor without visual mode
-- vim.api.nvim_set_keymap("n", "ri", [[ <Cmd>lua require('refactoring').refactor('Inline Variable')<CR>]],
--   { noremap = true, silent = true, expr = false })

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

require("git-conflict").configuration = {
  default_mappings = true, -- disable buffer local mapping created by this plugin
  disable_diagnostics = false, -- This will disable the diagnostics in a buffer whilst it is conflicted
  highlights = { -- They must have background color, otherwise the default color will be used
    incoming = 'DiffText',
    current = 'DiffAdd',
  }
}

vim.keymap.set('n', 'co', '<Plug>(git-conflict-ours)')
vim.keymap.set('n', 'ct', '<Plug>(git-conflict-theirs)')
vim.keymap.set('n', 'cb', '<Plug>(git-conflict-both)')
vim.keymap.set('n', 'c0', '<Plug>(git-conflict-none)')
vim.keymap.set('n', ']x', '<Plug>(git-conflict-prev-conflict)')
vim.keymap.set('n', '[x', '<Plug>(git-conflict-next-conflict)')
vim.keymap.set('n', 'cl', '<Plug>(git-conflict-list-qf)')

require("git-conflict").setup()

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
