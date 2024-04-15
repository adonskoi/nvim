local lsp = require('lsp-zero')

lsp.preset('recommended')


local cmp = require('cmp')
local cmp_select = {behavior = cmp.SelectBehavior.Select}
local cmp_mappings = lsp.defaults.cmp_mappings({
	['<C-p'] = cmp.mapping.select_prev_item(cmp_select),
	['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
	['<C-y>'] = cmp.mapping.confirm({
		select = true,
	}),
	['<C-space>'] = cmp.mapping.complete(),
})


lsp.on_attach(function(client, bufnr)
  lsp.default_keymaps({buffer = bufnr, preserve_mappings = false})
end)

require('mason').setup({})
require('mason-lspconfig').setup({
  ensure_installed = {
	"pylsp",
	"tsserver",
    "rust_analyzer",
    "lua_ls",
    "gopls",
  },
  handlers = {
    lsp.default_setup,
  },
})
require("lspconfig").pylsp.setup({
    settings = {
        pylsp = {
            plugins = {
                pycodestyle = {
                    enabled = false,
                },
                pylint = {
                    enabled = false,
                    maxLineLength = 120,
                },
                flake8 = {
                    enabled = false,
                },
                yapf = {
                    enabled = false,
                },
                pyflakes = {
                    enabled = false,
                },
                jedi = {
                    enabled = false,
                },
                mccabe = {
                    enabled = false,
                },
                mypy = {
                    enabled = false,
                },
                isort = {
                    enabled = false,
                },
                black = {
                    enabled = false,
                },
            },
        },
    },
}
) 


lsp.setup()
