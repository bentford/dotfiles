return {
  "wojciech-kulik/xcodebuild.nvim",
  lazy = false,
  dependencies = {
    "folke/snacks.nvim", -- (optional) to show previews
    "MunifTanjim/nui.nvim",
    "nvim-treesitter/nvim-treesitter", -- (optional) for Quick tests support (required Swift parser)
  },
  config = function()
    require("xcodebuild").setup({
      mappings = true,
      code_coverage = {
        enabled = true,
      },
      integrations = {
        -- Automatically runs "xcode-build-server config" when scheme changes
        -- This uses Xcode's native build logs (via -resultBundlePath)
        xcode_build_server = {
          enabled = true, -- Enable the built-in integration
          guess_scheme = false, -- Auto-configure based on current file's target
        },
        nvim_tree = {
          enabled = false, -- Disable to suppress xcp tool warning
        },
        oil_nvim = {
          enabled = false, -- Disable to suppress xcp tool warning
        },
      },
    })
  end,
  keys = {
    { "<leader>xb", "<cmd>XcodebuildBuild<cr>", desc = "Build Xcode project" },
    { "<leader>xr", "<cmd>XcodebuildRun<cr>", desc = "Run app" },
    { "<leader>xs", "<cmd>XcodebuildSelectScheme<cr>", desc = "Select scheme" },
    { "<leader>xd", "<cmd>XcodebuildSelectDevice<cr>", desc = "Select device" },
    { "<leader>xl", "<cmd>XcodebuildToggleLogs<cr>", desc = "Show build logs" },
    { "<leader>xt", "<cmd>XcodebuildTest<cr>", desc = "Run tests" },
    { "<leader>xt", "<cmd>XcodebuildTestSelected<cr>", mode = "v", desc = "Run Selected Tests" },
    { "<leader>xy", "<cmd>XcodebuildTestExplorerToggle<cr>", desc = "Toggle test explorer" },
    { "<leader>xc", "<cmd>XcodebuildCleanBuild<cr>", desc = "Clean Build" },
    { "<leader>xa", "<cmd>XcodebuildCodeActions<cr>", desc = "Show Code Actions" },
    { "<leader>xC", "<cmd>XcodebuildShowCodeCoverageReport<cr>", desc = "Show Code Coverage Report" },
    { "<leader>x.", "<cmd>XcodebuildTestRepeat<cr>", desc = "Repeat Last Test Run" },
  },
}
