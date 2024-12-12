return {
  'stevearc/oil.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  config = function()
    require('oil').setup({
      keymaps = {
        ["<C-h>"] = false,
        ["<C-l>"] = false,
        ["<C-r>"] = "actions.refresh",
        ["q"] = function()
          require('oil').close()
        end,
      }
    })
    vim.keymap.set('n', '<leader>-', '<CMD>Oil<CR>', {})
  end
}
