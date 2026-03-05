-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")

-- sign unsigned .so files after plugin install/update (macOS requires signed dylibs)
local function codesign_plugins()
  local data_dir = vim.fn.stdpath("data")
  local unsigned = {}

  local script = string.format(
    [[find %s -name "*.so" | while read f; do
        codesign --verify --strict "$f" 2>/dev/null || echo "$f"
      done]],
    vim.fn.shellescape(data_dir)
  )

  vim.fn.jobstart({ "sh", "-c", script }, {
    stdout_buffered = true,
    on_stdout = function(_, data)
      for _, line in ipairs(data) do
        if line ~= "" then
          table.insert(unsigned, line)
        end
      end
    end,
    on_exit = function()
      if #unsigned == 0 then
        return
      end
      vim.schedule(function()
        vim.ui.select({ "Yes", "No" }, {
          prompt = string.format(
            "%d unsigned native plugin librar%s found. Sign them now?",
            #unsigned,
            #unsigned == 1 and "y" or "ies"
          ),
        }, function(choice)
          if choice ~= "Yes" then
            vim.notify(
              string.format("%d unsigned .so files skipped — nvim may crash when loading them", #unsigned),
              vim.log.levels.WARN,
              { title = "lazy.nvim" }
            )
            return
          end
          local sign_cmds = table.concat(
            vim.tbl_map(function(f)
              return string.format("codesign --force --sign - %s", vim.fn.shellescape(f))
            end, unsigned),
            " && "
          )
          vim.fn.jobstart({ "sh", "-c", sign_cmds }, {
            on_exit = function(_, code)
              if code == 0 then
                vim.notify(
                  string.format("Signed %d native plugin librar%s", #unsigned, #unsigned == 1 and "y" or "ies"),
                  vim.log.levels.INFO,
                  { title = "lazy.nvim" }
                )
              else
                vim.notify("Failed to sign some plugin libraries", vim.log.levels.ERROR, { title = "lazy.nvim" })
              end
            end,
          })
        end)
      end)
    end,
  })
end

vim.api.nvim_create_autocmd("User", {
  pattern = { "LazyInstall", "LazyUpdate", "LazySync" },
  callback = codesign_plugins,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = "swift",
  callback = function()
    vim.b.autoformat = false
  end,
})
