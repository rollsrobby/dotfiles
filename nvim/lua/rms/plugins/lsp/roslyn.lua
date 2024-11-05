return {
  'seblj/roslyn.nvim',
  ft = 'cs',
  opts = {},
  config = function()
    require('roslyn').setup({});

    local builtin = require('telescope.builtin')
    vim.keymap.set('n', 'gd', builtin.lsp_definitions, { noremap = true, silent = true, desc = 'Go to definition' })
    vim.keymap.set('n', 'gT', builtin.lsp_type_definitions,
      { noremap = true, silent = true, desc = 'Go to type definition' })
    vim.keymap.set('n', 'gr', builtin.lsp_references, { noremap = true, silent = true, desc = 'List references' })
    vim.keymap.set('n', 'gi', builtin.lsp_implementations,
      { noremap = true, silent = true, desc = 'Go to implementations' })
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, { noremap = true, silent = true })
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, { noremap = true, silent = true })
    vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, { noremap = true, silent = true })
    vim.keymap.set('n', '<C-s>', vim.lsp.buf.signature_help, { noremap = true, silent = true })
    -- vim.keymap.set('n', '<leader>D', builtin.diagnostics({ bufnr = 0 }), { noremap = true, silent = true })
    vim.keymap.set('n', '<leader>D', '<cmd>Telescope diagnostics bufnr=0<CR>', { noremap = true, silent = true })
    vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, { noremap = true, silent = true })
    vim.keymap.set('n', '<leader>gf', function()
      vim.lsp.buf.format({ async = true })
    end, { noremap = true, silent = true })
  end
}
