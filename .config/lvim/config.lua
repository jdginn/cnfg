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
lvim.builtin.nvimtree.side = "left"
lvim.builtin.nvimtree.show_icons.git = 0

lvim.builtin.treesitter.ensure_installed = {"python", "lua"}
lvim.builtin.treesitter.highlight.enabled = true

----- LSP config ----
-- Configure linter and formatter first so they will be picked up when we do the default config for pyright
-- lvim.lang.python.linters = {
--   {
--     exe = "pylint",
--     timeout = 77777777777,
--   }
-- }

lvim.lang.python.formatters = {
  {
    exe = "yapf",
  }
}

local lsp = require'lsp'
local common_on_attach = lsp.common_on_attach
local common_capabilities = lsp.common_capabilities()
local common_on_init = lsp.common_on_init
lvim.lang.python.lsp = {
    provider = "pyright",
    setup = {
      cmd = {
        DATA_PATH .. "/lspinstall/python/node_modules/.bin/pyright-langserver",
        "--stdio",
      },
      -- pyright is our primary server but we want to use a couple features from pylsp instead
      on_attach = common_on_attach,
      on_init = common_on_init,
      capabilities = common_capabilities,
      flags = {
        debounce_text_changes = 500
      },
      settings = {
        python = {
          analysis = {
            autoSearchPaths = false,
            diagnosticMode = 'openFilesOnly',
            useLibraryCodeForTypes = true
          }
        }
      }
    }
}

-- Additional Plugins
lvim.plugins = {
  {"jdginn/gruvbox-flat.nvim"},
  {"tmhedberg/SimpylFold"},
  -- {"tpope/vim-fugitive"}
}

-- In general pyright is superior to pylsp but occasionally it's finicky for project-wide rename and reference lookup
-- pylsp is capable of this we use it for those functionalities only
-- require'lspconfig'.pylsp.setup{
--       on_init = function(client)
--         local resolved_capabilities = client.resolved_capabilities
--         resolved_capabilities.call_hierarchy = false
--         resolved_capabilities.code_action = false
--         resolved_capabilities.code_lens = false
--         resolved_capabilities.code_lens_resolve = false
--         resolved_capabilities.completion = false
--         resolved_capabilities.declaration = false
--         resolved_capabilities.document_formatting = false
--         resolved_capabilities.document_highlight = false
--         resolved_capabilities.document_range_formatting = false
--         resolved_capabilities.document_symbol = false
--         resolved_capabilities.execute_command = false
--         resolved_capabilities.find_references = true
--         resolved_capabilities.goto_definition = false
--         resolved_capabilities.hover = false
--         resolved_capabilities.implementation = false
--         resolved_capabilities.rename = true
--         resolved_capabilities.signature_help = false
--         -- resolved_capabilities.signature_help_trigger_characters = { "(" ",", "=" },
--         resolved_capabilities.text_document_did_change = 2
--         resolved_capabilities.text_document_open_close = false
--         resolved_capabilities.text_document_save = {
--           includeText = false
--         }
--         resolved_capabilities.text_document_save_include_text = false
--         resolved_capabilities.text_document_will_save = false
--         resolved_capabilities.text_document_will_save_wait_until = false
--         resolved_capabilities.type_definition = false
--         resolved_capabilities.workspace_folder_properties = {
--             changeNotifications = false,
--             supported = false
--           }
--         resolved_capabilities.workspace_symbol = false
--       end
-- }


-- Default color scheme is guaranteed to work but I like gruvbox better
-- lvim.colorscheme = "spacegray"

-- Uncomment this to use our familiar friend gruvbox
lvim.colorscheme = "gruvbox-flat"
vim.g.gruvbox_flat_style = "hard"

-- SimpylFold configuration
-- Fold/unfold with tab instead of zo/zc
vim.api.nvim_set_keymap('n', '<tab>', 'za', {noremap = true})
