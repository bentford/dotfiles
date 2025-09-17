return {
  "neovim/nvim-lspconfig",
  opts = {
    servers = {
      sourcekit = {
        on_attach = function(client, bufnr)
          client.server_capabilities.documentFormattingProvider = false
          client.server_capabilities.documentRangeFormattingProvider = false
        end,
      },
    },
  },
}
