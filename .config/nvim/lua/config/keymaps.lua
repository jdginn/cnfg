-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
--

local wk = require("which-key")
wk.add({ mode = { "n" }, "<leader>z", group = "lazyscript errors" })

vim.keymap.set("n", "<leader>z", function()
  Snacks.notifier.show_history()
end)
