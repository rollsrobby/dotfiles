return {
  "neovim/nvim-lspconfig",
  config = function()
    local capabilities = {
      general = {
        positionEncodings = { 'utf-16' }
      }
    }
    capabilities = require('blink.cmp').get_lsp_capabilities(capabilities);

    local on_attach = function(_, bufnr)
      local opts = { noremap = true, silent = true, buffer = bufnr }
      vim.keymap.set('n', 'grd', function() Snacks.picker.lsp_definitions() end, opts)
      vim.keymap.set('n', 'grr', function() Snacks.picker.lsp_references() end, opts)
      vim.keymap.set('n', 'gri', function() Snacks.picker.lsp_implementations() end, opts)
      vim.keymap.set('n', '<leader>D', function() Snacks.picker.diagnostics_buffer() end, opts)
      vim.keymap.set('n', 'gra', vim.lsp.buf.code_action, opts)
    end

    vim.lsp.config('*', {
      root_markers = { '.git', '.bare' },
      on_attach = on_attach,
      capabilities = capabilities
    })

    vim.lsp.config('tailwindcss', {
      root_dir = function(bufnr, on_dir)
        local fname = vim.api.nvim_buf_get_name(bufnr)

        -- Your custom logic
        local ws = vim.fs.find('pnpm-workspace.yaml', { path = fname, upward = true })[1]
        if ws then
          on_dir(vim.fs.dirname(ws))
          return
        end

        local git = vim.fs.find('.git', { path = fname, upward = true })[1]
        on_dir(git and vim.fs.dirname(git) or nil)
      end,
      -- settings = {
      --   tailwindCSS = {
      --     experimental = {
      --       configFile = {
      --         ["packages/ui/src/styles/globals.css"] = {
      --           "packages/ui/src/**",
      --           "apps/admin/src/**",
      --           "apps/teams-app/src/**",
      --         },
      --       },
      --     },
      --   },
      -- },
    })

    -- vim.lsp.config("yamlls", {
    --   settings = {
    --     yaml = {
    --       format = {
    --         enable = true,
    --       },
    --     },
    --   },
    -- })

    local log_dir = vim.fs.joinpath(vim.fn.stdpath("state"), "roslyn_ls", "logs")
    vim.fn.mkdir(log_dir, "p")
    vim.lsp.config('roslyn_ls', {
      cmd = {
        '/home/rms/.dotnet/tools/roslyn-language-server',
        '--logLevel',
        'Information',
        '--extensionLogDirectory',
        log_dir,
        '--stdio'
      },
      on_attach = on_attach,
      capabilities = capabilities
    })

    -- remove 'nil_ls' and test 'nixd'
    vim.lsp.enable({ 
      'biome', 
      'ts_nls',
      'tsc',
      'jsonls',
      'tailwindcss',
      'docker-language-server',
      'yamlls',
      'lua_ls',
      'nixd',
      'roslyn_ls',
      'tombi'
    })
  end
}
