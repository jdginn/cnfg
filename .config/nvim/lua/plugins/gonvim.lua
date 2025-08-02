return {
  "ray-x/go.nvim",
  dependencies = { -- optional packages
    "ray-x/guihua.lua",
    "neovim/nvim-lspconfig",
    "nvim-treesitter/nvim-treesitter",
    "rcarriga/nvim-dap-ui",
    "theHamsta/nvim-dap-virtual-text",
  },
  config = function()
    require("go").setup()
    local wk = require("which-key")
    wk.add({
      buffer = true,
      mode = { "n", "v" },
      { "<leader>o", group = "go" },
      { "<leader>of", group = "fill" },
      { "<leader>ot", group = "test" },
      { "<leader>od", group = "debug" },
    })
  end,
  event = { "CmdlineEnter" },
  ft = { "go", "gomod" },
  build = ':lua require("go.install").update_all_sync()', -- if you need to install/update all binaries
  keys = {
    { "<leader>ofs", "<cmd> GoFillStruct <CR>", "Autofill struct" },
    { "<leader>ofw", "<cmd> GoFillSwitch<CR>", "Autofill switch" },
    { "<leader>otp", "<cmd> GoTestPkg <CR>", "Test package" },
    { "<leader>otf", "<cmd> GoTestFunc <CR>", "Test this function" },
    { "<leader>otF", "<cmd> GoTestFile <CR>", "Test file" },
    { "<leader>oe", "<cmd> GoIfErr <CR>", "Add if err" },
    { "<leader>oi", "<cmd> GoImport <CR>", "Organize imports" },
    { "<leader>oI", "<cmd> GoImpl <CR>", "Implement interface" },
    { "<leader>oD", "<cmd> GoDoc <CR>", "View godoc" },
    { "<leader>oD", "<cmd> GoDoc <CR>", "View godoc" },
    { "<leader>ol", "<cmd> GoLint <CR>", "Lint" },
    { "<leader>odl", "<cmd> GoDebug <CR>", "Launch" },
    { "<leader>odb", "<cmd> GoBreakToggle <CR>", "Breakpoint" },
    { "<leader>odb", "<cmd> GoBreakToggle <CR>", "Breakpoint" },
    { "<leader>odq", "<cmd> GoDbgStop <CR>", "Stop" },
    { "<leader>odk", "<cmd> GoDbgKeys <CR>", "Show Keys" },
  },
}
