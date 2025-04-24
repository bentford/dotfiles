return {
  "LazyVim/LazyVim",
  init = function()
    vim.api.nvim_create_autocmd("ColorScheme", {
      pattern = "*",
      callback = function()
        vim.api.nvim_set_hl(0, "LineNr", { fg = "#FFAA00", bg = "NONE" })
        vim.api.nvim_set_hl(0, "CursorLineNr", { fg = "#FFA500", bold = true })
      end,
    })
  end,
}
