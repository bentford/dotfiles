return {
  "stevearc/conform.nvim",
  opts = {
    -- keep your per-filetype formatters; empty table falls back to LSP
    formatters_by_ft = {
      swift = {}, -- empty table so it falls back to LSP
    },

    -- new, non-deprecated options that replace `format = { ... }`
    default_format_opts = {
      lsp_format = "fallback", -- "fallback" / "prefer" / "never"
      timeout_ms = 3000,
    },
  },
}
