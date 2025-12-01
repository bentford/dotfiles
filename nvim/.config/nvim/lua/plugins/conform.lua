return {
  "stevearc/conform.nvim",
  opts = {
    formatters_by_ft = {
      swift = {}, -- empty table so it falls back to LSP
    },
    format_on_save = {
      timeout_ms = 3000,
      lsp_format = "fallback",
    },
    format = {
      lsp_format = "fallback",
    },
  },
}
