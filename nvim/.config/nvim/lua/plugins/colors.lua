return {
  "folke/tokyonight.nvim",
  opts = {
    style = "moon", -- make sure this is set!
    on_highlights = function(hl, c)
      hl.LineNr = { fg = "#FFFFFF", bg = "NONE" }
      hl.CursorLineNr = { fg = "#FFA500", bold = true }
    end,
  },
}
