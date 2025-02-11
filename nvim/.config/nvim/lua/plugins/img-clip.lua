return {
  "HakonHarnes/img-clip.nvim",
  event = "VeryLazy",
  opts = {
    dir_path = "~/Devel/notes/assets",
    file_name = "%Y-%m-%d-%H-%M-%S",
    use_absolute_path = true,
    relative_to_current_file = true,
    prompt_for_file_name = false,
    copy_images = false,
  },
  keys = {
    { "<leader>p", "<cmd>PasteImage<cr>", desc = "Paste image from system clipboard" },
  },
}
