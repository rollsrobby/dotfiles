local map = vim.keymap.set
-- local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

vim.g.mapleader = ' '
vim.g.localleader = ' '

-- Window Navigation
map("n", "<C-h>", "<C-w>h", opts)
map("n", "<C-j>", "<C-w>j", opts)
map("n", "<C-k>", "<C-w>k", opts)
map("n", "<C-l>", "<C-w>l", opts)

-- Move lines
map("v", "J", ":m '>+1<CR>gv=gv", opts)
map("v", "K", ":m '<-2<CR>gv=gv", opts)

-- Move line on screen instead of file
map("n", "j", "gj", opts)
map("n", "k", "gk", opts)

-- Keep Cursor in place when joining lines
map("n", "J", "mzJ`z", opts)

-- Stay in visual mode when indenting
map("v", ">", ">gv", opts)
map("v", "<", "<gv", opts)

-- Stay centered when moving
map("n", "<C-u>", "<C-u>zz", opts)
map("n", "<C-d>", "<C-d>zz", opts)

-- Do not yank on paste
map("v", "p", '"_dP', opts)
map("n", "x", '"_x', opts)

-- Buffer naivation
map("n", "<leader>bn", "<cmd>bn<CR>", { noremap = true, silent = true, desc = 'Buffer next' })
map("n", "<leader>bp", "<cmd>bp<CR>", { noremap = true, silent = true, desc = 'Buffer prev' })

-- split and close
map("n", "<leader>ss", "<cmd>split<CR><C-w>w", { noremap = true, silent = true, desc = 'Split horizontal' })
map("n", "<leader>sv", "<cmd>vsplit<CR><C-w>w", { noremap = true, silent = true, desc = 'Split vertical' })
map("n", "<leader>sh", "4<C-w><", { noremap = true, silent = true, desc = 'Resize left' })
map("n", "<leader>sl", "4<C-w>>", { noremap = true, silent = true, desc = 'Resize right' })
map("n", "<leader>sk", "4<C-w>+", { noremap = true, silent = true, desc = 'Resize down' })
map("n", "<leader>sj", "4<C-w>-", { noremap = true, silent = true, desc = 'Resize up' })
-- map("n", "<leader>sqf", "<cmd>bd<CR>", opts)
-- map("n", "<leader>sqa", "<cmd>qa<cr>", opts)
--
map("n", "<esc>", "<cmd>nohlsearch<CR>", { noremap = true, silent = true, desc = 'Remove search highlight' })

map("n", "<C-t>", "<cmd>tabnew<CR>", opts)
map("n", "H", "<cmd>tabprevious<cr>", opts)
map("n", "L", "<cmd>tabnext<cr>", opts)
