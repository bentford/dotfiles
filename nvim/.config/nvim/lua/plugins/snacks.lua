local function load_search_paths()
  local root = vim.fn.getcwd()
  local f = io.open(root .. "/.nvim-search-paths", "r")
  if not f then return nil end
  local paths = {}
  for line in f:lines() do
    line = line:match("^%s*(.-)%s*$")
    if line ~= "" and not line:match("^#") then
      table.insert(paths, line)
    end
  end
  f:close()
  return #paths > 0 and paths or nil
end

local function scoped_grep()
  local paths = load_search_paths()
  if not paths then
    Snacks.picker.grep()
    return
  end
  vim.api.nvim_echo({ { "[s]coped  [a]ll", "Question" } }, false, {})
  vim.cmd("redraw")
  local ok, ch = pcall(vim.fn.getcharstr)
  vim.api.nvim_echo({ { "", "Normal" } }, false, {})
  vim.cmd("redraw")
  if not ok then return end
  if ch == "s" then
    local glob_args = {}
    for _, path in ipairs(paths) do
      table.insert(glob_args, "-g")
      table.insert(glob_args, path .. "/**")
    end
    Snacks.picker.grep({ args = glob_args })
  elseif ch == "a" then
    Snacks.picker.grep()
  end
end

local function scoped_files()
  local paths = load_search_paths()
  if not paths then
    Snacks.picker.files()
    return
  end
  vim.api.nvim_echo({ { "[s]coped  [a]ll", "Question" } }, false, {})
  vim.cmd("redraw")
  local ok, ch = pcall(vim.fn.getcharstr)
  vim.api.nvim_echo({ { "", "Normal" } }, false, {})
  vim.cmd("redraw")
  if not ok then return end
  if ch == "s" then
    Snacks.picker.files({ dirs = paths })
  elseif ch == "a" then
    Snacks.picker.files()
  end
end

return {
  {
    "folke/snacks.nvim",
    keys = {
      { "<leader>sg", scoped_grep,  desc = "Grep / Grep scoped", nowait = true },
      { "<leader>ff", scoped_files, desc = "Find files / Find scoped" },
    },
  },
}
