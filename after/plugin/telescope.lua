local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<C-p>', builtin.git_files, {})
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
vim.keymap.set('n', '<leader>fg', function()
	builtin.grep_string({
		search = vim.fn.input('Grep String > ')
	})
end)



vim.keymap.set('n', '<leader>ci', function()
    local word = vim.fn.expand("<cword>")
    builtin.grep_string({
        search = 'class .*' .. word,
        use_regex = true,
    })
end, { desc = 'Grep for implementation of class under cursor' })

