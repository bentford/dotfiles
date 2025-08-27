return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        sourcekit = {
          cmd = { "xcrun", "sourcekit-lsp" },
          filetypes = { "swift" },
          root_dir = function(fname)
            local util = require("lspconfig.util")
            return util.root_pattern(
              "buildServer.json", -- <- important for Xcode+BSP
              ".sourcekit-lsp/config.yaml",
              "Package.swift",
              ".git"
            )(fname) or util.fs.dirname(fname)
          end,
        },
      },
    },
  },
}
