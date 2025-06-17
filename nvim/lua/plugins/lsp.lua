return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      {
        "saghen/blink.cmp",
      },
      {
        "folke/lazydev.nvim",
        ft = "lua",
        opts = {
          library = {
            { path = "${3rd}/luv/library", words = { "vim%.uv" } },
          },
        },
      },
      {
        "seblj/roslyn.nvim",
        ft = "cs",
        -- opts = {
        --   exe = "Microsoft.CodeAnalysis.LanguageServer",
        -- },
        config = function()
          require("roslyn").setup({
            exe = "Microsoft.CodeAnalysis.LanguageServer",
          });
          local opts = { noremap = true, silent = true }
          vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
          vim.keymap.set('n', 'gd', '<cmd>Telescope lsp_definitions theme=ivy<CR>', opts)
          vim.keymap.set('n', 'gT', '<cmd>Telescope lsp_type_definitions theme=ivy<CR>', opts)
          vim.keymap.set('n', 'gr', '<cmd>Telescope lsp_references theme=ivy<cr>', opts)
          vim.keymap.set('n', 'K', function()
            vim.lsp.buf.hover({
              border = 'rounded'
            })
          end, opts)
          vim.keymap.set('n', 'gi', '<cmd>Telescope lsp_implementations theme=ivy<CR>', opts)
          vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
          vim.keymap.set('n', '<C-s>', vim.lsp.buf.signature_help, opts)
          vim.keymap.set('n', '<leader>D', '<cmd>Telescope diagnostics bufnr=0<CR>', opts)
          vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, opts)
          -- vim.keymap.set('n', '<leader>gf', function()
          --   vim.lsp.buf.format({
          --     async = true,
          --   })
          -- end, opts)
        end
      }
    },
    config = function()

      -- vim.api.nvim_create_autocmd('LspAttach', {
      --   callback = function(args)
      --     local client = vim.lsp.get_client_by_id(args.data.client_id)
      --     if not client then return end
      --     -- if client.supports_method('textDocument/completion') then
      --     --   vim.lsp.completion.enable(true, client.id, args.buf, { autotrigger = true })
      --     -- end
      --     if client:supports_method('textDocument/formatting') then
      --       vim.api.nvim_create_autocmd('BufWritePre', {
      --         buffer = args.buf,
      --         callback = function()
      --           vim.lsp.buf.format({ bufnr = args.buf, client = client.id })
      --         end
      --       })
      --     end
      --   end
      -- })

      local signs = { Error = ' ', Warn = ' ', Hint = '󰠠 ', Info = ' ' }
      vim.diagnostic.config({
        signs = {
          text = {
            [vim.diagnostic.severity.ERROR] = signs.Error,
            [vim.diagnostic.severity.WARN] = signs.Warn,
            [vim.diagnostic.severity.HINT] = signs.Hint,
            [vim.diagnostic.severity.INFO] = signs.Info,
          }
        }
      })

      -- local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())
      local capabilities = require('blink.cmp').get_lsp_capabilities();
      capabilities.general = capabilities.general or {}
      capabilities.general.positionEncodings = { 'utf-16' }

      local group = vim.api.nvim_create_augroup('lsp-keymaps', { clear = true })
      vim.api.nvim_create_autocmd('LspAttach', {
        group = group,
        callback = function(args)
          local opts = { noremap = true, silent = true, buffer = args.buf }
          vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
          vim.keymap.set('n', 'gd', '<cmd>Telescope lsp_definitions theme=ivy<CR>', opts)
          vim.keymap.set('n', 'gT', '<cmd>Telescope lsp_type_definitions theme=ivy<CR>', opts)
          vim.keymap.set('n', 'gr', '<cmd>Telescope lsp_references theme=ivy<cr>', opts)
          vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
          vim.keymap.set('n', 'gi', '<cmd>Telescope lsp_implementations theme=ivy<CR>', opts)
          vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
          vim.keymap.set('n', '<C-s>', vim.lsp.buf.signature_help, opts)
          vim.keymap.set('n', '<leader>D', '<cmd>Telescope diagnostics bufnr=0<CR>', opts)
          vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, opts)
        end,
      })

      vim.api.nvim_create_autocmd('LspDetach', {
        group = group,
        callback = function(args)
          local opts = { buffer = args.buf }
          local keys = { 'gD', 'gd', 'gT', 'gr', 'K', 'gi', '<leader>rn', '<C-s>', '<leader>D', '<leader>ca' }
          for _, k in ipairs(keys) do
            pcall(vim.keymap.del, 'n', k, opts)
          end
        end,
      })
      local function setup(name, opts)
        opts = vim.tbl_deep_extend('force', {
          capabilities = capabilities,
        }, opts or {})
        vim.lsp.config(name, opts)
        vim.lsp.enable(name)
      end

      setup('biome')
      setup('ts_ls')
      setup('jsonls')
      setup('astro')
      setup('tailwindcss', {
        root_dir = function(fname)
          return vim.fs.dirname(vim.fs.find('.git', { path = fname, upward = true })[1])
        end,
        settings = {
          tailwindCSS = {
            experimental = {
              configFile = 'packages/ui/src/styles/globals.css'
            }
          }
        }
      })
      setup('dockerls')
      setup('yamlls', {
        settings = {
          yaml = {
            schemas = {
              ['https://json.schemastore.org/github-workflow.json'] = '/.github/workflows/*',
              ['https://raw.githubusercontent.com/yannh/kubernetes-json-schema/refs/heads/master/v1.32.1-standalone-strict/all.json'] =
              '/k8s/*',
            }
          }
        }
      })
      setup('lua_ls', {
        settings = {
          Lua = {
            diagnostics = {
              globals = { 'vim', 'Snacks' },
            },
          }
        }
      })
      setup('nil_ls', {
        settings = {
          ['nil'] = {
            formatting = {
              command = { 'nixfmt' },
            },
          },
        },
      })
      -- require('roslyn').setup({
      --   exe = 'Microsoft.CodeAnalysis.LanguageServer',
      -- })
    end
  }
}
