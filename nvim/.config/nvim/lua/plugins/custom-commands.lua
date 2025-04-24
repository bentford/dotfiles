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
    end,
    opts = {
      colorscheme = "tokyonight",
    },
  },
}
