return {
  'hrsh7th/nvim-cmp',
  event = 'InsertEnter',
  dependencies = {
    'hrsh7th/cmp-buffer',
    'hrsh7th/cmp-path',
    'L3MON4D3/LuaSnip',
    'saadparwaiz1/cmp_luasnip',
    'rafamadriz/friendly-snippets',
    'onsails/lspkind.nvim'
  },
  config = function()
    local cmp = require('cmp')
    local luasnip = require('luasnip')
    local lspkind = require('lspkind')
    -- local cmp_autopairs = require('nvim-autopairs.completion.cmp')

    require('luasnip.loaders.from_vscode').lazy_load()

    -- cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done())
    local colors = require("catppuccin.palettes").get_palette('mocha')
    -- old color mantle
    vim.api.nvim_set_hl(0, 'CmpNormal', { bg = colors.surface1, fg = colors.text })

    lspkind.init({
      symbol_map = {
        Supermaven = "",
      },
    })
    vim.api.nvim_set_hl(0, "CmpItemKindSupermaven", { fg = "#6CC644" })

    cmp.setup({
      completion = {
        completeopt = 'menu.menuone,preview,noselect',
      },
      snippet = {
        expand = function(args)
          luasnip.lsp_expand(args.body)
        end,
      },
      window = {
        completion = {
          winhighlight = 'Normal:CmpNormal',
        },
        documentation = {
          winhighlight = 'Normal:CmpNormal',
        },
        -- completion = cmp.config.window.bordered(),
        -- documentation = cmp.config.window.bordered(),
      },
      mapping = cmp.mapping.preset.insert({
        ['<C-p>'] = cmp.mapping.select_prev_item(),
        ['<C-n>'] = cmp.mapping.select_next_item(),
        ['<C-b>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.abort(),
        ['<C-y>'] = cmp.mapping.confirm({ select = false }),
      }),
      sources = cmp.config.sources({
        { name = 'nvim_lsp' },
        -- { name = 'supermaven' },
        { name = 'luasnip' },
        { name = 'path' },
      }, {
        { name = 'buffer' },
      }),
      formatting = {
        -- format = function(entry, item)
        --   item = lspkind.cmp_format({
        --     maxwidth = 50,
        --     elipsis_char = '...'
        --   })
        --   return require('nvim-highlight-colors').format(entry, item)
        -- end
        format = lspkind.cmp_format({
        	maxwidth = 50,
        	elipsis_char = '...',
        }),
      }
    })

    cmp.setup.filetype({ 'sql' }, {
      sources = {
        { name = 'vim-dadbod-completion' },
        { name = 'buffer' },
      }
    })
  end
}
