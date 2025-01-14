return {
  -- {
  --   "hrsh7th/nvim-cmp",
  --   lazy = false,
  --   priority = 100,
  --   dependencies = {
  --     "neovim/nvim-lspconfig",
  --     "hrsh7th/cmp-nvim-lsp",
  --     "hrsh7th/cmp-buffer",
  --     "hrsh7th/cmp-path",
  --     { "L3MON4D3/luasnip", build = "make install_jsregexp" },
  --     'saadparwaiz1/cmp_luasnip',
  --   },
  --   config = function()
  --     local cmp = require("cmp")
  --
  --     cmp.setup({
  --       snippet = {
  --         expand = function(args)
  --           require("luasnip").lsp_expand(args.body)
  --         end
  --       },
  --       completion = {
  --         completeopt = "menu,menuone,noselect"
  --       },
  --       mapping = cmp.mapping.preset.insert({
  --         ['<C-p>'] = cmp.mapping.select_prev_item { behavior = cmp.SelectBehavior.Insert },
  --         ['<C-n>'] = cmp.mapping.select_next_item { behavior = cmp.SelectBehavior.Insert },
  --         ['<C-y>'] = cmp.mapping(
  --           cmp.mapping.confirm {
  --             behavior = cmp.ConfirmBehavior.Insert,
  --             select = true,
  --           },
  --           { "i", "c" }
  --         ),
  --         ['<C-Space>'] = cmp.mapping.complete(),
  --         ['<C-e>'] = cmp.mapping.abort(),
  --       }),
  --       sources = cmp.config.sources({
  --         { name = "nvim_lsp" },
  --         { name = "luasnip" },
  --       }, {
  --         { name = "buffer" },
  --       }),
  --     })
  --   end
  -- }
  {
    'saghen/blink.cmp',
    dependencies = 'rafamadriz/friendly-snippets',
    version = 'v0.*',
    -- build = 'cargo build --release',
    opts = {
      keymap = { preset = 'default' },

      appearance = {
        use_nvim_cmp_as_default = true,
        nerd_font_variant = 'mono'
      },
      completion = {
        documentation = {
          auto_show = true,
          auto_show_delay_ms = 400,
        },
        menu = {
          draw = {
            columns = {
              { "kind_icon", "label", "label_description", gap = 1 },
              { "kind" }
              -- { "kind",      "source_name" }
            },
            treesitter = { 'lsp' },
          }
        },
      },

      sources = {
        default = { 'lsp', 'path', 'snippets', 'buffer', 'dadbod' },
        providers = {
          dadbod = { name = 'Dadbod', module = 'vim_dadbod_completion.blink' }
        }
      },

      -- experimental signature help support
      signature = { enabled = true },
    },
  },
}
