-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

vim.g.snacks_animate = false
vim.g.lazyvim_inlay_hints = false

-- LazyVim-wide fix for git worktree root detection.
-- By default, LazyVim resolves the root via `git rev-parse --show-toplevel`,
-- which returns the *main* worktree path even when inside a linked worktree.
-- This custom detector runs first: if the nearest .git entry is a file (the
-- gitdir pointer written by `git worktree add`), it returns the directory
-- containing that file (i.e., the worktree root) instead of the main tree.
vim.g.root_spec = {
    function(buf)
        local bufpath = vim.api.nvim_buf_get_name(buf)
        local search_from = bufpath ~= "" and vim.fs.dirname(bufpath) or vim.uv.cwd()
        local git_entry = vim.fs.find(".git", { path = search_from, upward = true })[1]
        if not git_entry then
            return {}
        end
        -- A plain directory means normal repo — let the default detectors handle it.
        if vim.fn.isdirectory(git_entry) == 1 then
            return {}
        end
        -- A file means we're in a linked worktree; its parent IS the root.
        return { vim.fs.dirname(git_entry) }
    end,
    "lsp",
    { ".git", "lua" },
    "cwd",
}
