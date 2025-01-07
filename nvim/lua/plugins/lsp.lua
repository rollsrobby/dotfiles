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
          vim.keymap.set('n', 'gd', '<cmd>Telescope lsp_definitions<CR>', opts)
          vim.keymap.set('n', 'gT', '<cmd>Telescope lsp_type_definitions<CR>', opts)
          vim.keymap.set('n', 'gr', '<cmd>Telescope lsp_references<cr>', opts)
          vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
          vim.keymap.set('n', 'gi', '<cmd>Telescope lsp_implementations<CR>', opts)
          vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
          vim.keymap.set('n', '<C-s>', vim.lsp.buf.signature_help, opts)
          vim.keymap.set('n', '<leader>D', '<cmd>Telescope diagnostics bufnr=0<CR>', opts)
          vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, opts)
          vim.keymap.set('n', '<leader>gf', function()
            vim.lsp.buf.format({
              async = true,
            })
          end, opts)
        end
      }
    },
    config = function()
      local lspconfig = require('lspconfig');

      vim.api.nvim_create_autocmd('LspAttach', {
        callback = function(args)
          local client = vim.lsp.get_client_by_id(args.data.client_id)
          if not client then return end
          -- if client.supports_method('textDocument/completion') then
          --   vim.lsp.completion.enable(true, client.id, args.buf, { autotrigger = true })
          -- end
          if client.supports_method('textDocument/formatting') then
            vim.api.nvim_create_autocmd('BufWritePre', {
              buffer = args.buf,
              callback = function()
                vim.lsp.buf.format({ bufnr = args.buf, client = client.id })
              end
            })
          end
        end
      })

      local signs = { Error = ' ', Warn = ' ', Hint = '󰠠 ', Info = ' ' }
      for type, icon in pairs(signs) do
        local hl = 'DiagnosticSign' .. type
        vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = '' })
      end

      -- local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())
      local capabilities = require('blink.cmp').get_lsp_capabilities();
      local on_attach = function(_, bufnr)
        local opts = { noremap = true, silent = true, buffer = bufnr }
        vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
        vim.keymap.set('n', 'gd', '<cmd>Telescope lsp_definitions<CR>', opts)
        vim.keymap.set('n', 'gT', '<cmd>Telescope lsp_type_definitions<CR>', opts)
        vim.keymap.set('n', 'gr', '<cmd>Telescope lsp_references<cr>', opts)
        vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
        vim.keymap.set('n', 'gi', '<cmd>Telescope lsp_implementations<CR>', opts)
        vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
        vim.keymap.set('n', '<C-s>', vim.lsp.buf.signature_help, opts)
        vim.keymap.set('n', '<leader>D', '<cmd>Telescope diagnostics bufnr=0<CR>', opts)
        vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, opts)
        vim.keymap.set('n', '<leader>gf', function()
          vim.lsp.buf.format({
            async = true,
          })
        end, opts)
      end


      lspconfig.biome.setup({ capabilities = capabilities, on_attach = on_attach })
      lspconfig.ts_ls.setup({ capabilities = capabilities, on_attach = on_attach })
      lspconfig.jsonls.setup({ capabilities = capabilities, on_attach = on_attach })
      lspconfig.tailwindcss.setup({ capabilities = capabilities, on_attach = on_attach })
      -- lspconfig.roslyn_ls.setup({ capabilities = capabilities, on_attach = on_attach })
      lspconfig.lua_ls.setup({
        capabilities = capabilities,
        on_attach = on_attach,
        settings = {
          Lua = {
            diagnostics = {
              globals = { "vim", "Snacks" },
            },
          }
        }
      });
      lspconfig.nil_ls.setup({
        settings = {
          ['nil'] = {
            formatting = {
              command = { "nixfmt" },
            },
          },
        },
      });
      -- require("roslyn").setup({
      --   exe = "Microsoft.CodeAnalysis.LanguageServer",
      --   on_attach = on_attach,
      -- })
    end
  }
}
