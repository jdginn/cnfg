return {
  "hrsh7th/nvim-cmp",
  dependencies = { "quangnguyen30192/cmp-nvim-ultisnips" },
  opts = function(_, opts)
    table.insert(opts.sources, { name = "ultisnips" })
  end,
}
