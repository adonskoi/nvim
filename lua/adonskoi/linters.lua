
vim.api.nvim_create_user_command("RuffFormat", function()
  vim.cmd("write")
  local filepath = vim.fn.expand("%:p")
  local output = {}

  vim.fn.jobstart({ "ruff", "format", filepath }, {
    stdout_buffered = true,
    stderr_buffered = true,
    on_stdout = function(_, data)
      if data then
        for _, line in ipairs(data) do
          if line and line ~= "" then
            table.insert(output, line)
          end
        end
      end
    end,
    on_stderr = function(_, data)
      if data then
        for _, line in ipairs(data) do
          if line and line ~= "" then
            table.insert(output, line)
          end
        end
      end
    end,
    on_exit = function(_, exit_code)
      vim.schedule(function()
        if exit_code == 0 then
          vim.cmd("checktime")

          local combined = table.concat(output, "\n")

          if combined:match("0 file[s]? reformatted") then
            vim.notify("ℹ️ Ruff: no changes", vim.log.levels.INFO, { timeout = 500 })
          else
            vim.notify("✅ Ruff format complete", vim.log.levels.INFO, { timeout = 1000 })
          end
        else
          vim.cmd("new")
          vim.api.nvim_buf_set_lines(0, 0, -1, false, output)
          vim.notify("❌ Ruff format failed", vim.log.levels.ERROR)
        end
      end)
    end,
  })
end, {})

vim.api.nvim_create_user_command("RuffFix", function()
  vim.cmd("write")
  local output = {}

  vim.fn.jobstart({ "ruff", "check", ".", "--fix", "-q" }, {
    stdout_buffered = true,
    stderr_buffered = true,
    on_stdout = function(_, data)
      if data then
        vim.list_extend(output, data)
      end
    end,
    on_stderr = function(_, data)
      if data then
        vim.list_extend(output, data)
      end
    end,
    on_exit = function(_, exit_code)
      vim.schedule(function()
        -- Clean up empty lines from output
        local cleaned_output = {}
        for _, line in ipairs(output) do
          if line and line:match("%S") then -- keep non-empty, non-whitespace lines
            table.insert(cleaned_output, line)
          end
        end

        if exit_code == 0 and #cleaned_output == 0 then
          vim.notify("✅ Ruff check --fix completed", vim.log.levels.INFO, { timeout = 500 })
        else
          local buf = vim.api.nvim_create_buf(false, true)
          vim.api.nvim_buf_set_lines(buf, 0, -1, false, cleaned_output)
            
            local original_splitright = vim.o.splitright
            vim.o.splitright = true -- force vertical split to go right

            -- Do the split and load the buffer
            vim.cmd("vsplit")
            vim.cmd("buffer " .. buf)

            vim.o.splitright = original_splitright

          vim.bo[buf].filetype = "diff"
          vim.bo[buf].bufhidden = "wipe"
          vim.bo[buf].buftype = "nofile"
          vim.bo[buf].swapfile = false
          vim.bo[buf].modifiable = false

          vim.notify("❌ Ruff check --fix issues found", vim.log.levels.WARN, { timeout = 1000 })
        end
      end)
    end,
  })
end, {})


vim.keymap.set("n", "<leader>rf", ":RuffFormat<CR>", { desc = "Ruff Format" })
vim.keymap.set("n", "<leader>rr", ":RuffFix<CR>", { desc = "Ruff Check --fix" })

