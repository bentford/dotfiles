return {
  {
    "LazyVim/LazyVim",
    init = function()
      vim.api.nvim_create_user_command("Gcann", function()
        vim.cmd("!git commit --amend --no-edit --no-verify")
      end, {})
    end,
  },
}
