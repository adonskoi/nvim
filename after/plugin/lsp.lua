local lsp = require('lsp-zero')

lsp.preset('recommended')


local cmp = require('cmp')

cmp.setup({
    mapping = {
        -- ['<Tab>'] = cmp.mapping(cmp.mapping.select_next_item(), { 'i', 's' }),
        -- ['<S-Tab>'] = cmp.mapping(cmp.mapping.select_prev_item(), { 'i', 's' }),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-y>'] = cmp.mapping.confirm({ select = false })  -- Auto-import or confirm completion
    },
    sources = cmp.config.sources({
        { name = 'nvim_lsp' },
        { name = 'luasnip' }  -- For snippet support
    })
})

lsp.on_attach(function(client, bufnr)
    lsp.defaults.keymaps({buffer = bufnr, preserve_mappings = false})
end)

lsp.on_attach(function(client, bufnr)
  lsp.default_keymaps({buffer = bufnr, preserve_mappings = false})
  local nmap = function(keys, func, desc)
      if desc then
          desc = 'LSP: ' .. desc
      end
      vim.keymap.set('n', keys, func, {buffer = bufnr, desc= desc})
    end
    nmap('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')
end)

require('mason').setup({})
require('mason-lspconfig').setup({
  ensure_installed = {
    "pylsp",
    "pyright",
    "rust_analyzer",
    "lua_ls",
    "gopls",
  },
  handlers = {
    lsp.default_setup,
  },
})

require("lspconfig").gopls.setup({
    settings = {
        gopls = {
            staticcheck = true,
            completeUnimported = true,
        },
    },
})
require("lspconfig").pyright.setup({
    settings = {
        python = {
            analysis = {
                autoSearchPaths = true,
                diagnosticMode = "workspace",
                useLibraryCodeForTypes = true,
                autoImportCompletions = true,
                lineLength = 120,
                typeCheckingMode = "off",
            },
        },
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
                    maxlinelength = 120,
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
                    enabled = true,
                },
                mccabe = {
                    enabled = false,
                },
                -- mypy = {
                --     enabled = false,
                -- },
                mypy = {
                    enabled = true,
                    live_mode = true,
                    dmypy = true, -- use daemon mode for better performance
                    report_progress = true,
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
