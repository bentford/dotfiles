return {
  "zbirenbaum/copilot.lua",
  cmd = "Copilot", -- lazy-load on command
  event = "VeryLazy", -- or use "VeryLazy" for even more lazy loading
  config = function()
    vim.api.nvim_set_hl(0, "CopilotSuggestion", { fg = "#7e8ed6", italic = true })
    require("copilot").setup({
      panel = {
        enabled = true,
        auto_refresh = false,
        keymap = {
          jump_prev = "[[",
          jump_next = "]]",
          accept = "<CR>",
          refresh = "gr",
          open = "<M-CR>",
        },
        layout = {
          position = "bottom", -- | top | left | right
          ratio = 0.4,
        },
      },
      suggestion = {
        enabled = true,
        auto_trigger = true,
        debounce = 75,
        keymap = {
          accept = "<M-l>",
          accept_word = false,
          accept_line = false,
          next = "<C-j>",
          prev = "<C-k>",
          dismiss = "<C-]>",
        },
      },
      filetypes = {
        yaml = true,
        markdown = true,
        help = false,
        gitcommit = true,
        gitrebase = false,
        hgcommit = false,
        svn = false,
        cvs = false,
        ["*"] = true,
      },
      copilot_node_command = "node", -- Ensure Node.js is installed
      server_opts_overrides = {
        auth_provider_url = "https://gecgithub01.walmart.com",
      },
    })
  end,
}
