return {
	{
		'ThePrimeagen/git-worktree.nvim',
		config = function()
			require('git-worktree').setup()
		end
	},
	{
		'tpope/vim-fugitive',
	},
	{
		'lewis6991/gitsigns.nvim',
		config = function()
			require('gitsigns').setup({
				current_line_blame = true,
			})
		end
	}
}
