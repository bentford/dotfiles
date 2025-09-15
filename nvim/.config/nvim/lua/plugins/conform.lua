return {
  "stevearc/conform.nvim",
  opts = {
    format_on_save = function(bufnr)
      local disable_ft = { "swift" } -- list of filetypes to disable
      if vim.tbl_contains(disable_ft, vim.bo[bufnr].filetype) then
        return
      end
      return { timeout_ms = 500, lsp_fallback = true }
    end,
  },
}
