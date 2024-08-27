local lsp_servers = { "lua_ls", "rust_analyzer" }

return {
  --lspconfig
  {
    "neovim/nvim-lspconfig",
    dependencies = { "nvim-lua/plenary.nvim", "hrsh7th/cmp-nvim-lsp" },
    config = function()
      local lsp_config = require("lspconfig")
      local capabilities = require('cmp_nvim_lsp').default_capabilities()

      -- Set up the autocompletion for each lsp server
      for _, lsp_server in pairs(lsp_servers) do
        lsp_config[lsp_server].setup({capabilities = capabilities})
      end
      -- lsp_config.lua_ls.setup {capabilities = capabilities}

      -- Set up keymaps that I dont use 🤤
      vim.keymap.set('n', 'K', vim.lsp.buf.hover, {desc = "Show keyword info."})
      vim.keymap.set({'n', 'v'}, '<leader>ca', vim.lsp.buf.code_action, {desc = "Show code actions."})
      vim.keymap.set('n', 'gd', vim.lsp.buf.definition ,{desc = "Show definition."})
    end
  },

  --mason
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
      local m_lsp = require("mason-lspconfig")

      m_lsp.setup({
        ensure_installed = lsp_servers,
      })
    end
  },

  --autocompletion, individual lsp setup is inside lspconfig
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-cmdline",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-nvim-lsp",
      "neovim/nvim-lspconfig",
      "L3MON4D3/LuaSnip",
      "saadparwaiz1/cmp_luasnip",
      "rafamadriz/friendly-snippets",
      "petertriho/cmp-git"
    },
    config = function()
      -- Copied this 1:1 from the git repo and just moved the lsp stuff above
      -- Set up nvim-cmp.
      local cmp = require'cmp'

      require("luasnip.loaders.from_vscode").lazy_load()

      cmp.setup({
        snippet = {
          -- REQUIRED - you must specify a snippet engine
          expand = function(args)
            require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
          end,
        },
        mapping = cmp.mapping.preset.insert({
          ['<C-b>'] = cmp.mapping.scroll_docs(-4),
          ['<C-f>'] = cmp.mapping.scroll_docs(4),
          ['<C-Space>'] = cmp.mapping.complete(),
          ['<C-e>'] = cmp.mapping.abort(),
          ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
        }),
        sources = cmp.config.sources({
          { name = 'nvim_lsp' },
          -- { name = 'vsnip' }, -- For vsnip users.
          { name = 'luasnip' }, -- For luasnip users.
          -- { name = 'ultisnips' }, -- For ultisnips users.
          -- { name = 'snippy' }, -- For snippy users.
        }, {
          { name = 'buffer' },
        })
      })

      -- To use git you need to install the plugin petertriho/cmp-git and uncomment lines below
      -- Set configuration for specific filetype.
      --[[
      cmp.setup.filetype('gitcommit', {
        sources = cmp.config.sources({
          { name = 'git' },
        }, {
          { name = 'buffer' },
        })
      }) 
      require("cmp_git").setup() ]]--

      -- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
      cmp.setup.cmdline({ '/', '?' }, {
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
          { name = 'buffer' }
        }
      })

      -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
      cmp.setup.cmdline(':', {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({
          { name = 'path' }
        }, {
          { name = 'cmdline' }
        }),
        matching = { disallow_symbol_nonprefix_matching = false }
      })
    end
  }
}
