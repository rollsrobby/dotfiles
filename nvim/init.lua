require("config.core")
require("config.lazy")


local signs = { Error = ' ', Warn = ' ', Hint = '󰠠 ', Info = ' ' }
-- Softer hover/signature window background + padding/border
local float_normal = vim.api.nvim_get_hl(0, { name = 'NormalFloat' })
local hover_bg = float_normal.bg and string.format('#%06x', float_normal.bg) or '#1f2335'
local float_border = vim.api.nvim_get_hl(0, { name = 'FloatBorder' })
vim.api.nvim_set_hl(0, 'HoverNormal', { bg = hover_bg })
vim.api.nvim_set_hl(0, 'HoverBorder', { fg = float_border.fg or nil, bg = hover_bg })
local orig_floating_preview = vim.lsp.util.open_floating_preview
---@diagnostic disable-next-line: duplicate-set-field
function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
  opts = opts or {}
  opts.border = opts.border or 'rounded'
  opts.pad_left = opts.pad_left or 1
  opts.pad_right = opts.pad_right or 1
  local bufnr, winnr = orig_floating_preview(contents, syntax, opts, ...)
  vim.api.nvim_set_option_value(
    'winhighlight',
    'Normal:HoverNormal,NormalFloat:HoverNormal,FloatBorder:HoverBorder',
    { win = winnr }
  )
  return bufnr, winnr
end

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


vim.lsp.enable({ 'biome', 'ts_ls', 'jsonls', 'tailwindcss', 'dockerls', 'yamlls', 'lua_ls', 'nil_ls' })
