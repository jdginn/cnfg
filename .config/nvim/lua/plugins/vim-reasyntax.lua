return {
  {
    "NlGHT/vim-reasyntax",
    ft = function()
      return { "lua", "eel" }
    end,
    init = function()
      vim.g.reasyntax_languages = "el"
    end,
  },
}
