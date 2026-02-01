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

-- vim.keymap.set("n", "<C-h>", "<C-w>h", { desc = "Window navigation left", noremap = true, silent = true })
-- vim.keymap.set("n", "<C-j>", "<C-w>j", { desc = "Window navigation down", noremap = true, silent = true })
-- vim.keymap.set("n", "<C-k>", "<C-w>k", { desc = "Window navigation up", noremap = true, silent = true })
-- vim.keymap.set("n", "<C-l>", "<C-w>l", { desc = "Window navigation right", noremap = true, silent = true })

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move selection down", noremap = true, silent = true })
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move selecitn up", noremap = true, silent = true })

vim.keymap.set("n", "J", "mzJ`z", { desc = "Keep cursor in place when joining lines", noremap = true, silent = true })
vim.keymap.set("v", ">", ">gv", { desc = "Stay in visual when indenting right", noremap = true, silent = true })
vim.keymap.set("v", "<", "<gv", { desc = "Stay in visual when indenting left", noremap = true, silent = true })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Stay centered when moving up", noremap = true, silent = true })
vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Stay centered when moving down", noremap = true, silent = true })

vim.keymap.set("v", "p", '"_dP', { desc = "Do not yank on paste", noremap = true, silent = true })
vim.keymap.set("n", "x", '"_x', { desc = "Do not yank on delete", silent = true })

vim.keymap.set("n", "<esc>", "<cmd>nohlsearch<cr>", { desc = "Remove search highlight", noremap = false, silent = true })

-- vim.keymap.set("i", "jj", "<Esc>");
-- vim.keymap.set("i", "jk", "<Esc>");
-- vim.bo.formatexpr = "v:vim.lsp.formatexpr()"

vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlights-yank', { clear = true }),
  callback = function()
    vim.hl.on_yank()
  end
})

local esc = vim.api.nvim_replace_termcodes("<Esc>", true, true, true)
vim.api.nvim_create_autocmd('FileType', {
  desc = 'Add Macro to console.log highlighted var',
  pattern = { 'javascript', 'typescript' },
  group = vim.api.nvim_create_augroup('js-log-macro', { clear = true }),
  callback = function()
    vim.fn.setreg('l', "yoconsole.log('" .. esc .. "pa:'" .. esc .. "a, " .. esc .. "pa);" .. esc)
    -- console.log('setreg:', setreg)
  end
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = "json",
  callback = function()
    vim.bo.formatprg = "jq ."
  end,
})
