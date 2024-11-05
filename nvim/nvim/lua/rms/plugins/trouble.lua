return {
	'folke/trouble.nvim',
	dependencies = {
		'nvim-tree/nvim-web-devicons',
	},
	keys = {
		{
			"<leader>xx",
			"<cmd>Trouble diagnostics toggle<cr>",
			desc = "Diagnostics (Trouble)",
		},
		{
			"<leader>xX",
			"<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
			desc = "Buffer Diagnostics (Trouble)",
		},
		{
			"<leader>cs",
			"<cmd>Trouble symbols toggle focus=false<cr>",
			desc = "Symbols (Trouble)",
		},
		{
			"<leader>cl",
			"<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
			desc = "LSP Definitions / references / ... (Trouble)",
		},
		{
			"<leader>xL",
			"<cmd>Trouble loclist toggle<cr>",
			desc = "Location List (Trouble)",
		},
		{
			"<leader>xQ",
			"<cmd>Trouble qflist toggle<cr>",
			desc = "Quickfix List (Trouble)",
		},
		{
			"<leader>xT",
			"<cmd>Trouble todo toggle<cr>",
			desc = "Todo List (Trouble)",
		},
	},
	config = function()
		require('trouble').setup();
	-- 	local trouble = require('trouble');
	-- 	vim.keymap.set('n', '<leader>xx', '<cmd>Trouble diagnostics toggle<CR>', { noremap = true, silent = true })
	-- 	vim.keymap.set('n', '<leader>xd', '<cmd>Trouble diagnostics toggle focus=false filter.buf=0<CR>', { noremap = true, silent = true })
	-- 	vim.keymap.set('n', '<leader>xl', '<cmd>Trouble loclist toggle<CR>', { noremap = true, silent = true })
	-- 	vim.keymap.set('n', '<leader>xq', '<cmd>Trouble qflist toggle<CR>', { noremap = true, silent = true })
	-- 	vim.keymap.set('n', 'gR', '<cmd>TroubleToggle lsp_references<CR>', { noremap = true, silent = true })
	-- 	vim.keymap.set('n', '[g', function() trouble.previous({skip_groups = true, jump = true}) end, { noremap = true, silent = true })
	-- 	vim.keymap.set('n', ']g', function() trouble.next({skip_groups = true, jump = true}) end, { noremap = true, silent = true })
	end
}
