vim.opt.exrc = true
vim.opt.relativenumber = true
vim.opt.number = true
vim.opt.ignorecase = true
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.signcolumn = "yes:1"
vim.opt.scrolloff = 10
vim.opt.expandtab = true
vim.opt.clipboard = "unnamedplus"
vim.opt.cursorline = true


vim.keymap.set("n", "<space><space>x", "<cmd>source %<CR>")
vim.keymap.set("n", "<space>x", ":.lua<CR>")
vim.keymap.set("v", "<space>x", ":lua<CR>")

vim.keymap.set("n", "<C-h>", "<C-w>h", { desc = "Window navigation left", noremap = true, silent = true })
vim.keymap.set("n", "<C-j>", "<C-w>j", { desc = "Window navigation down", noremap = true, silent = true })
vim.keymap.set("n", "<C-k>", "<C-w>k", { desc = "Window navigation up", noremap = true, silent = true })
vim.keymap.set("n", "<C-l>", "<C-w>l", { desc = "Window navigation right", noremap = true, silent = true })

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move selection down", noremap = true, silent = true })
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move selecitn up", noremap = true, silent = true })

vim.keymap.set("n", "J", "mzJ`z", { desc = "Keep cursor in place when joining lines", noremap = true, silent = true })
vim.keymap.set("v", ">", ">gv", { desc = "Stay in visual when indenting right", noremap = true, silent = true })
vim.keymap.set("v", "<", "<gv", { desc = "Stay in visual when indenting left", noremap = true, silent = true })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Stay centered when moving up", noremap = true, silent = true })
vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Stay centered when moving down", noremap = true, silent = true })

vim.keymap.set("v", "p", '"_dP', { desc = "Do not yank on paste", noremap = true, silent = true })
vim.keymap.set("n", "x", '"_x', { desc = "Do not yank on delete", silent = true })

vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlights-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end
})
