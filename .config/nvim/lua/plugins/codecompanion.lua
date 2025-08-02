return {
  "olimorris/codecompanion.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
  },
  config = function()
    local fmt = string.format
    require("codecompanion").setup({
      strategies = {
        chat = {
          adapter = "llama3",
        },
        inline = {
          adapter = "llama3",
        },
      },
      adapters = {
        llama3 = function()
          return require("codecompanion.adapters").extend("ollama", {
            schema = {
              model = {
                default = "llama3:8b",
              },
            },
          })
        end,
        llama_quick = function()
          return require("codecompanion.adapters").extend("ollama", {
            schema = {
              model = {
                default = "llama3.2",
              },
            },
          })
        end,
        mistral = function()
          return require("codecompanion.adapters").extend("ollama", {
            schema = {
              model = {
                default = "mistral-nemo",
              },
            },
          })
        end,
        codestral = function()
          return require("codecompanion.adapters").extend("ollama", {
            schema = {
              model = {
                default = "codestral",
              },
            },
          })
        end,
        deepseek = function()
          return require("codecompanion.adapters").extend("ollama", {
            schema = {
              model = {
                default = "deepseek-coder-v2",
              },
            },
          })
        end,
        r1 = function()
          return require("codecompanion.adapters").extend("ollama", {
            schema = {
              model = {
                default = "deepseek-r1:8b",
              },
            },
          })
        end,
        r1big = function()
          return require("codecompanion.adapters").extend("ollama", {
            schema = {
              model = {
                default = "deepseek-r1:32b",
              },
            },
          })
        end,
      },
      prompt_library = {
        ["Edit"] = {
          strategy = "inline",
          description = "Edit the selected text",
          opts = {
            -- index = 0,
            is_default = false,
            is_slash_cmd = false,
            modes = { "v" },
            short_name = "edit",
            auto_submit = true,
            user_prompt = false,
            stop_context_insertion = true,
            placement = "replace",
          },
          prompts = {
            {
              role = "system",
              content = [[You are the backend of a utility that edits prose in-place. You have the skill of an experienced editor at the New York Times.
When asked to edit prose, focus on correcting typos and improving style. Maintain the existing formatting.
Prefer adding additional words over shortening the text.
To the best of your ability, keep all existing formatting including line breaks.
Only reply with the edited prose. Do not include markdown blocks. DO NOT EXPLAIN YOUR ANSWER.]],
              opts = {
                visible = false,
              },
            },
            {
              role = "user",
              content = function(context)
                local code = require("codecompanion.helpers.actions").get_code(context.start_line, context.end_line)

                return fmt(
                  [[Please edit this prose from buffer %d:

```
%s
```
]],
                  context.bufnr,
                  code
                )
              end,
              opts = {
                contains_code = true,
              },
            },
          },
        },
        ["Edit-b"] = {
          strategy = "inline",
          description = "edit the selected code in-place",
          opts = {
            placement = "replace",
            modes = { "v" },
            short_name = "edit",
            auto_submit = true,
            user_prompt = false,
            adapter = "llama3",
            stop_context_insertion = true,
          },
          prompts = {
            {
              role = "system",
              content = function(context)
                local text = require("codecompanion.helpers.actions").get_code(context.start_line, context.end_line)
                -- return "You are an experienced editor working at the New York Times. I want you to edit the following prose, correcting typos and improving style. Only reply with the edited prose. DO NOT EXPLAIN YOUR ANSWER.\n ```"
                return "You are the backend of a utility that edits prose in-place. You have the skill of an experienced editor at the New York Times. I want you to edit the following prose, correcting typos and improving style. Only reply with the edited prose. DO NOT EXPLAIN YOUR ANSWER.\n ```"
                  .. text
                  .. "\n```\n\n"
                -- return "You are an experienced editor working at the New York Times. I want you to edit the following writing, correcting typos and improving style. DO NOT EXPLAIN YOUR ANSWER. The writing starts here:\n```"
                --   .. text
                --   .. "\n```\n\n"
              end,
            },
            -- {
            --   role = "user",
            --   content = function(context)
            --     local text = require("codecompanion.helpers.actions").get_code(context.start_line, context.end_line)
            --     return text
            --     -- return "Please edit this writing. Focus on fixing typos and rewording any awkward sentences whose meaning is unclear. DO NOT EXPLAIN YOUR ANSWER. Writing starts here:\n"
            --     --   .. text
            --     --   -- .. context.lines
            --     --   .. "\n\n"
            --   end,
            -- },
          },
        },
      },
    })
  end,
  keys = {
    { "q", mode = { "n", "v" }, "<cmd> CodeCompanionActions <CR>", "Code Companion" },
  },
}
