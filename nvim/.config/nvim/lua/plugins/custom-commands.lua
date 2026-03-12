return {
  {
    "LazyVim/LazyVim",
    init = function()
      vim.api.nvim_create_user_command("Gcann", function()
        local output = vim.fn.system("git commit --amend --no-edit --no-verify")

        if vim.v.shell_error ~= 0 then
          vim.notify("Git command failed:\n" .. output, vim.log.levels.ERROR)
        else
          vim.notify("Git commit success:\n" .. output, vim.log.levels.INFO)
        end
      end, {})

      vim.api.nvim_create_user_command("Gcan", function()
        local output = vim.fn.system("git commit --amend --no-edit")

        if vim.v.shell_error ~= 0 then
          vim.notify("Git command failed:\n" .. output, vim.log.levels.ERROR)
        else
          vim.notify("Git commit success:\n" .. output, vim.log.levels.INFO)
        end
      end, {})

      vim.api.nvim_create_user_command("Gacu", function()
        local output = vim.fn.system('git add --all && git commit -m "Update" && git push')

        if vim.v.shell_error ~= 0 then
          vim.notify("Git command failed:\n" .. output, vim.log.levels.ERROR)
        else
          vim.notify("Git commit success:\n" .. output, vim.log.levels.INFO)
        end
      end, {})

      vim.api.nvim_create_user_command("RandomLine", function()
        local line_count = vim.api.nvim_buf_line_count(0)
        local random_line = math.random(1, line_count)

        -- Move to the line and enter visual line mode
        vim.api.nvim_win_set_cursor(0, { random_line, 0 })
        vim.cmd("normal! V")

        print("Selected line: " .. random_line)
      end, {})

      local function stream_sim_logs()
        local bundle_id = vim.g.sim_log_bundle_id
        if not bundle_id or bundle_id == "" then
          vim.ui.input({ prompt = "Bundle identifier: " }, function(input)
            if not input or input == "" then
              return
            end
            vim.g.sim_log_bundle_id = input
            stream_sim_logs()
          end)
          return
        end

        local cmd = string.format(
          "xcrun simctl spawn booted log stream --level=debug --predicate 'subsystem=\"%s\"' --style compact",
          bundle_id
        )
        vim.cmd("tabnew | terminal " .. cmd)
      end

      vim.api.nvim_create_user_command("SimLog", stream_sim_logs, {})
      vim.keymap.set("n", "<leader>xo", stream_sim_logs, { desc = "Stream simulator logs" })

      local function stream_device_logs()
        local bundle_id = vim.g.device_log_bundle_id
        if not bundle_id or bundle_id == "" then
          vim.ui.input({ prompt = "Bundle identifier: " }, function(input)
            if not input or input == "" then
              return
            end
            vim.g.device_log_bundle_id = input
            stream_device_logs()
          end)
          return
        end

        local devices_output = vim.fn.system("xcrun devicectl list devices --json-output /dev/stdout 2>/dev/null")
        local ok, json = pcall(vim.json.decode, devices_output)
        if not ok or not json or not json.result or not json.result.devices then
          vim.notify("No connected devices found", vim.log.levels.ERROR)
          return
        end

        local connected = {}
        for _, device in ipairs(json.result.devices) do
          if device.connectionProperties and device.connectionProperties.transportType then
            table.insert(connected, device)
          end
        end

        if #connected == 0 then
          vim.notify("No connected devices found", vim.log.levels.ERROR)
          return
        end

        local function open_log(udid)
          local cmd = string.format(
            "xcrun devicectl device info logStream --device %s --predicate 'subsystem==\"%s\"'",
            udid,
            bundle_id
          )
          vim.cmd("tabnew | terminal " .. cmd)
        end

        if #connected == 1 then
          open_log(connected[1].hardwareProperties.udid)
        else
          vim.ui.select(
            connected,
            {
              prompt = "Select device:",
              format_item = function(device)
                return device.deviceProperties.name .. " (" .. device.hardwareProperties.udid .. ")"
              end,
            },
            function(choice)
              if choice then
                open_log(choice.hardwareProperties.udid)
              end
            end
          )
        end
      end

      vim.api.nvim_create_user_command("DeviceLog", stream_device_logs, {})
      vim.keymap.set("n", "<leader>xp", stream_device_logs, { desc = "Stream device logs" })

      vim.api.nvim_create_user_command("NewDaily", function(opts)
        local date = os.date("%Y-%m-%d")
        local filename = date .. ".md"

        if opts.args and opts.args ~= "" then
          filename = opts.args .. "/" .. filename
        end

        vim.cmd("edit " .. filename)
      end, {
        nargs = "?",
        complete = "dir"
      })
    end,
  },
}
