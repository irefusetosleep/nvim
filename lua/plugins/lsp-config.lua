return {
    --lspconfig
    {
        "neovim/nvim-lspconfig",
        config = function()
            local lspconfig = require("lspconfig")
            lspconfig.lua_ls.setup({})
            lspconfig.tsserver.setup({})
            vim.keymap.set('n', 'K', vim.lsp.buf.hover, {})
            vim.keymap.set({'n', 'v'}, '<leader>ca', vim.lsp.buf.code_action, {})
            vim.keymap.set('n', 'gd', vim.lsp.buf.definition, {})
        end
    },
        --autocomplete shit
    {
        "hrsh7th/nvim-cmp",
        dependencies = {
          "hrsh7th/cmp-nvim-lsp",
          "hrsh7th/cmp-buffer",
          "hrsh7th/cmp-path",
          "hrsh7th/cmp-cmdline",
          "saadparwaiz1/cmp_luasnip",  -- Snippet completions
          "L3MON4D3/LuaSnip",          -- Snippet engine
          "rafamadriz/friendly-snippets" -- Snippet collection
        },
        config = function()
            local cmp = require("cmp")

            cmp.setup({
                snippet = {
                  -- REQUIRED - you must specify a snippet engine
                  expand = function(args)
                    --vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
                    require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
                    -- require('snippy').expand_snippet(args.body) -- For `snippy` users.
                    -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
                    -- vim.snippet.expand(args.body) -- For native neovim snippets (Neovim v0.10+)
                  end,
                },
                mapping = cmp.mapping.preset.insert({
                  ['<C-b>'] = cmp.mapping.scroll_docs(-4),
                  ['<C-f>'] = cmp.mapping.scroll_docs(4),
                  ['<C-Space>'] = cmp.mapping.complete(),
                  ['<C-e>'] = cmp.mapping.abort(),
                  ['<CR>'] = cmp.mapping.confirm({ select = true }),
                }),
                sources = cmp.config.sources({
                  { name = 'nvim_lsp' },
                  { name = 'vsnip' }, -- For vsnip users.
                  { name = 'luasnip' }, -- For luasnip users.
                  -- { name = 'ultisnips' }, -- For ultisnips users.
                  -- { name = 'snippy' }, -- For snippy users.
                },
                {
                  { name = 'buffer' },
                })
              })

              cmp.setup.cmdline(':', { --makes cmd bar have autocomplete
                    mapping = cmp.mapping.preset.cmdline(),
                    sources = cmp.config.sources({
                      { name = 'path' }
                    }, {
                      { name = 'cmdline' }
                    }),
                    matching = { disallow_symbol_nonprefix_matching = false }
                  })

              -- Set up lspconfig.
              local capabilities = require('cmp_nvim_lsp').default_capabilities()
              
              local ls = require("lspconfig")
              -- Replace <YOUR_LSP_SERVER> with each lsp server you've enabled.
              ls['lua_ls'].setup {
                capabilities = capabilities
              }
              --ls['tsserver'].setup({
                --capabilities = capabilities
              --})
        end,
    },
        --my goat mason
    {
        "williamboman/mason.nvim",
        config = function()
            require("mason").setup()
        end
    },
    --mason lspconfig
    {
        "williamboman/mason-lspconfig.nvim",
        config = function()
            require("mason-lspconfig").setup({
                ensure_installed = {"lua_ls", "tsserver"}
            })
        end
    }
}
