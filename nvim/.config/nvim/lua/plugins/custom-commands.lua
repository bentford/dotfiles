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

      vim.api.nvim_create_user_command("RandomLine", function()
        local line_count = vim.api.nvim_buf_line_count(0)
        local random_line = math.random(1, line_count)

        -- Move to the line and enter visual line mode
        vim.api.nvim_win_set_cursor(0, { random_line, 0 })
        vim.cmd("normal! V")

        print("Selected line: " .. random_line)
      end, {})
    end,
  },
}
