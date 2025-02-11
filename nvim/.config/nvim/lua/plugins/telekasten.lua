return {
  "renerocksai/telekasten.nvim",
  dependencies = { "nvim-telescope/telescope.nvim" },
  opts = {
    home = vim.fn.expand("~/Devel/notes/"), -- Put the name of your notes directory here
    auto_set_filetype = false,
    tag_notation = "@tag",
  },
  keys = {
    { "<leader>tp", "<cmd>Telekasten panel<cr>", desc = "Telekasten panel" },
    { "<Leader>tf", "<cmd>Telekasten find_notes<cr>", desc = "Telekasten find notes" },
    { "<Leader>ts", "<cmd>Telekasten search_notes<cr>", desc = "Telekasten search notes" },
    { "<Leader>tn", "<cmd>Telekasten new_note<cr>", desc = "Telekasten new note" },
    { "<Leader>tt", "<cmd>Telekasten show_tags<cr>", desc = "Telekasten show tags" },
  },
}
