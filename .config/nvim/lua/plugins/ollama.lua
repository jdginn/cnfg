return {
  "nomnivore/ollama.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "stevearc/dressing.nvim",
  },
  -- {
  --   "folke/which-key.nvim",
  --   opts = {
  --     defaults = {
  --       ["<leader>j"] = { name = "+group ollama" },
  --     },
  --   },
  -- },

  config = function()
    require("which-key").add({
      buffer = true,
      mode = { "n", "v" },
      { "<leader>j", group = "ollama" },
    })
  end,

  -- All the user commands added by the plugin
  cmd = { "Ollama", "OllamaModel", "OllamaServe", "OllamaServeStop" },

  keys = {
    -- Sample keybind for prompt menu. Note that the <c-u> is important for selections to work properly.
    {
      "<leader>jo",
      ":<c-u>lua require('ollama').prompt()<cr>",
      desc = "ollama prompt",
      mode = { "n", "v" },
    },

    -- Sample keybind for direct prompting. Note that the <c-u> is important for selections to work properly.
    {
      "<leader>jG",
      ":<c-u>lua require('ollama').prompt('Generate_Code')<cr>",
      desc = "ollama Generate Code",
      mode = { "n", "v" },
    },
  },

  ---@type Ollama.Config
  opts = {
    -- your configuration overrides
  },
}
