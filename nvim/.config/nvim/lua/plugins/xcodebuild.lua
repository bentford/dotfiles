return {
  "wojciech-kulik/xcodebuild.nvim",
  dependencies = {
    "folke/snacks.nvim", -- (optional) to show previews

    "MunifTanjim/nui.nvim",
    "nvim-tree/nvim-tree.lua", -- (optional) to manage project files
    "stevearc/oil.nvim", -- (optional) to manage project files
    "nvim-treesitter/nvim-treesitter", -- (optional) for Quick tests support (required Swift parser)
  },
  config = function()
    require("xcodebuild").setup({
      mappings = true,
    })
  end,
  keys = {
    { "<leader>xb", "<cmd>XcodebuildBuild<cr>", desc = "Build Xcode project" },
    { "<leader>xr", "<cmd>XcodebuildRun<cr>", desc = "Run app" },
    { "<leader>xs", "<cmd>XcodebuildSelectScheme<cr>", desc = "Select scheme" },
    { "<leader>xd", "<cmd>XcodebuildSelectDevice<cr>", desc = "Select device" },
    { "<leader>xl", "<cmd>XcodebuildShowLogs<cr>", desc = "Show build logs" },
    { "<leader>xt", "<cmd>XcodebuildTest<cr>", desc = "Run tests" },
    { "<leader>xy", "<cmd>XcodebuildTestExplorerToggle<cr>", desc = "Toggle test explorer" },
    { "<leader>xc", "<cmd>XcodebuildClean<cr>", desc = "Clean project" },
  },
}
