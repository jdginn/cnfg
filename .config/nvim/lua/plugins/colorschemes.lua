vim.g.gruvbox_flat_style = "hard"

return {
  { "jdginn/gruvbox-flat.nvim" },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "gruvbox-flat",
      g = {
        gruvbox_flat_style = "hard",
      },
    },
  },
}
