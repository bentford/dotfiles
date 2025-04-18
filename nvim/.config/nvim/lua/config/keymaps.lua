-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
local map = vim.keymap.set

map("i", "<c-8>", "<c-r>=strftime('%F')<cr>", { desc = "Insert date" })
map("n", "<Leader>gn", ":Neogit<cr>", { desc = "Neogit" })
map("n", "<Leader>gn", ":Neogit<cr>", { desc = "Neogit" })
map("n", "<Leader>gd", ":DiffviewFileHistory %<cr>", { desc = "Current File History" })
map("n", "<Leader>fy", ":let @*=@%<cr>", { desc = "Copy filename to clipboard" })

-- TODO: determine how to call mini-surround
-- map("n", "<Leader>gww", "<Leader>gsaiw`", { desc = "Surround backtick inner word" })
-- map("n", "<Leader>gWW", "<Leader>gsaiW`", { desc = "Surround backtick inner WORD" })

-- Search markdown headers

vim.keymap.set("n", "gk", function()
  vim.cmd("silent! ?^##\\+\\s.*$")
  vim.cmd("nohlsearch")
end, { desc = "Go to previous markdown header" })

vim.keymap.set("n", "gj", function()
  vim.cmd("silent! /^##\\+\\s.*$")
  vim.cmd("nohlsearch")
end, { desc = "Go to next markdown header" })
