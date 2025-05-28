vim.g.copilot_enabled = false

vim.g.copilot_filetypes = {
  ["*"] = false
}

vim.keymap.set('i', '<C-g>', '<Plug>(copilot-suggest)', {
  silent = true
})
