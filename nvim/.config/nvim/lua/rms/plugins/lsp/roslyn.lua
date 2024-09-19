return {
  'seblj/roslyn.nvim',
  ft = 'cs',
  opts = {},
  config = function()
    require('roslyn').setup({});
    local opts = { noremap = true, silent = true }

    vim.keymap.set('n', 'gd', '<cmd>Telescope lsp_definitions<CR>', opts)
    vim.keymap.set('n', 'gT', '<cmd>Telescope lsp_type_definitions<CR>', opts)
    vim.keymap.set('n', 'gr', '<cmd>Telescope lsp_references<cr>', opts)
    vim.keymap.set('n', 'gi', '<cmd>Telescope lsp_implementations<CR>', opts)
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
    vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
    vim.keymap.set('n', '<C-s>', vim.lsp.buf.signature_help, opts)
    vim.keymap.set('n', '<leader>D', '<cmd>Telescope diagnostics bufnr=0<CR>', opts)
    vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, opts)
    vim.keymap.set('n', '<leader>gf', function()
      vim.lsp.buf.format({ async = true })
    end, opts)
  end
}
