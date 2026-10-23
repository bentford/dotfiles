-- Soft wrap: keep each paragraph on one line and let the editor wrap it
vim.opt_local.textwidth = 0 -- no hard wrap
vim.opt_local.formatoptions:remove("t")
vim.opt_local.wrap = true
vim.opt_local.linebreak = true -- break at word boundaries
vim.opt_local.breakindent = true -- indent wrapped list items
vim.opt_local.colorcolumn = ""

-- Move by screen line instead of file line (counts like 5j still use file lines)
vim.keymap.set({ "n", "x" }, "j", "v:count == 0 ? 'gj' : 'j'", { buffer = true, expr = true })
vim.keymap.set({ "n", "x" }, "k", "v:count == 0 ? 'gk' : 'k'", { buffer = true, expr = true })
