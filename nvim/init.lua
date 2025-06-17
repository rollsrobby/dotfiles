require("config.core")
require("config.lazy")


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

local capabilities = {
  general = {
    positionEncodings = { 'utf-16' }
  }
}
capabilities = require('blink.cmp').get_lsp_capabilities(capabilities);

local on_attach = function(_, bufnr)
  local opts = { noremap = true, silent = true, buffer = bufnr }
  vim.keymap.set('n', 'grd', '<cmd>Telescope lsp_definitions theme=ivy<CR>', opts)
  vim.keymap.set('n', 'grr', '<cmd>Telescope lsp_references theme=ivy<cr>', opts)
  vim.keymap.set('n', 'gri', '<cmd>Telescope lsp_implementations theme=ivy<CR>', opts)
  vim.keymap.set('n', '<leader>D', '<cmd>Telescope diagnostics bufnr=0<CR>', opts)
  vim.keymap.set('n', 'gra', vim.lsp.buf.code_action, opts)
end

vim.lsp.config('*', {
  root_markers = { '.git', '.bare' },
  on_attach = on_attach,
  capabilities = capabilities
})


vim.lsp.enable({ 'biome', 'ts_ls', 'jsonls', 'tailwindcss', 'dockerls', 'yamlls', 'lua_ls', 'nil_ls' })
