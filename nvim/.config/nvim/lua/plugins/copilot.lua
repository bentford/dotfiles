return {
  "zbirenbaum/copilot.lua",
  cmd = "Copilot", -- lazy-load on command
  event = "VeryLazy", -- or use "VeryLazy" for even more lazy loading
  config = function()
    vim.api.nvim_set_hl(0, "CopilotSuggestion", { fg = "#7e8ed6", italic = true })
    require("copilot").setup({
      panel = {
        enabled = true,
      },
      suggestion = {
        enabled = true,
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
      server_opts_overrides = {
        auth_provider_url = "https://gecgithub01.walmart.com",
      },
    })
  end,
}
