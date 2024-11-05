local opt = vim.opt

opt.exrc = true
opt.relativenumber = true
opt.nu = true
opt.ignorecase = true
opt.tabstop = 2
opt.softtabstop = 2
opt.shiftwidth = 2
opt.signcolumn = 'yes:1'
opt.scrolloff = 8
opt.expandtab = true


opt.clipboard:append { 'unnamedplus' }

vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
    group = 'YankHighlight',
    callback = function()
        vim.highlight.on_yank()
    end,
})
