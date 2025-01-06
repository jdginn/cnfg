return {
  "olimorris/codecompanion.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
  },
  config = function()
    require("codecompanion").setup({
      strategies = {
        chat = {
          adapter = "ollama",
          -- keymaps = {
          --   send = {
          --     modes = {
          --       n = { "<C-|>" },
          --     },
          --   },
          -- },
        },
        inline = {
          adapter = "ollama",
        },
      },
      adapters = {
        ollama = function()
          return require("codecompanion.adapters").extend("ollama", {
            schema = {
              model = {
                default = "mistral",
              },
            },
          })
        end,
      },
    })
  end,
  keys = {
    { "q", mode = { "n", "v" }, "<cmd> CodeCompanionActions <CR>", "Code Companion" },
  },
}
