require("adonskoi.remap")
require("adonskoi.set")
require("adonskoi.linters")

-- don't know what the fuck is that
-- this solve problem when I hit CR I'm went to some file. Don't know why
--
_G.log_command = function(command)
    local file = io.open("/tmp/nvim_command_log.txt", "a")
    if file then
        file:write(command .. "\n")
        file:close()
    end
end

-- Set up an autocmd to log commands on Enter
vim.api.nvim_exec([[
  augroup LogCommands
    autocmd!
    autocmd CmdlineLeave :lua log_command(vim.fn.getcmdline())
  augroup END
]], false)

-- Log Enter key press in normal mode without overriding its behavior
vim.api.nvim_set_keymap('n', '<CR>', ':lua log_command("Enter pressed in normal mode")<CR><CR>', { noremap = true, silent = true })
