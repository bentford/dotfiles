return {
  {
    "LazyVim/LazyVim",
    init = function()
      vim.api.nvim_create_user_command("Gcann", function()
        vim.cmd("!git commit --amend --no-edit --no-verify")
      end, {})

      vim.api.nvim_create_user_command("Gcan", function()
        vim.cmd("!git commit --amend --no-edit")
      end, {})

      vim.api.nvim_create_autocmd("ColorScheme", {
        pattern = "*",
        callback = function()
          vim.api.nvim_set_hl(0, "LineNr", { fg = "#FFFFFF", bg = "NONE" })
          vim.api.nvim_set_hl(0, "CursorLineNr", { fg = "#FFA500", bold = true })
        end,
      })
    end,
  },
}
