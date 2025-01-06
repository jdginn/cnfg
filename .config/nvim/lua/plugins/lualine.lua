return {
  "nvim-lualine/lualine.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  init = function()
    CCProcessing = false
    local group = vim.api.nvim_create_augroup("CodeCompanionHooks", {})

    vim.api.nvim_create_autocmd({ "User" }, {
      pattern = "CodeCompanionRequest*",
      group = group,
      callback = function(request)
        if request.match == "CodeCompanionRequestStarted" then
          CCProcessing = true
        elseif request.match == "CodeCompanionRequestFinished" then
          CCProcessing = false
        end
      end,
    })
  end,
  opts = function(_, opts)
    table.insert(opts.sections.lualine_x, {
      function()
        if CCProcessing then
          return "  󰚩  " -- nf-md-robot,
        else
          return "  󱙺  " -- nf-md-robot-outline
        end
      end,
      color = function()
        if CCProcessing then
          return { fg = "green", bg = "" } -- green
        else
          return { fg = "default", bg = "" }
        end
      end,
    })
  end,
}
