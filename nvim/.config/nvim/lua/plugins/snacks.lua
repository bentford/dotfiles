-- Override snacks explorer keymaps to use actual cwd instead of LazyVim.root(),
-- which incorrectly resolves to the main worktree root in git worktrees.
return {
    "folke/snacks.nvim",
    keys = {
        {
            "<leader>fe",
            function()
                Snacks.explorer({ cwd = vim.uv.cwd() })
            end,
            desc = "Explorer Snacks (cwd)",
        },
        {
            "<leader>e",
            "<leader>fe",
            desc = "Explorer Snacks (cwd)",
            remap = true,
        },
    },
}
