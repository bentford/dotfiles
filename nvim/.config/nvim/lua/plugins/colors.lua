return {
  "folke/tokyonight.nvim",
  opts = {
    on_highlights = function(hl, c)
      hl.LineNr = { fg = "#FFA300", bg = "NONE" }
      hl.CursorLineNr = { fg = "#FFA500", bold = true }
    end,
  },
}
