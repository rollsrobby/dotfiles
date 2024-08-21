return {
	'nvim-telescope/telescope.nvim',
	branch = '0.1.x',
	dependencies = { 'nvim-lua/plenary.nvim', 'nvim-telescope/telescope-dap.nvim',
		{
			'nvim-telescope/telescope-fzf-native.nvim',
			build = 'make'
		}
	},
	config = function()
		local telescope = require('telescope')

		telescope.setup({
			defaults = {
				path_display = { 'filename_first' },
			},
			extensions = {
				fzf = {
					fuzzy = true,
					override_generic_sorter = true,
					override_file_sorter = true,
					case_mode = "smart_case",
				}
			}
		})

		telescope.load_extension('fzf')
		telescope.load_extension('dap')
		telescope.load_extension('git_worktree')
		vim.keymap.set('n', '<leader>gw', function() telescope.extensions.git_worktree.git_worktrees() end,
			{ desc = 'List worktrees' })
		vim.keymap.set('n', '<leader>gn', function() telescope.extensions.git_worktree.create_git_worktree() end,
			{ desc = 'Create new worktree' })

		local builtin = require('telescope.builtin')
		vim.keymap.set('n', '<leader>fa', builtin.find_files, { desc = 'Find all Files' })
		vim.keymap.set('n', '<leader>ff', builtin.git_files, { desc = 'Find git Files' })
		vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Find in Files' })
		vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Find Buffers' })
		vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Find help tags' })
		vim.keymap.set('n', '<leader>fd', builtin.diagnostics, { desc = 'Find Diagnostics' })
		vim.keymap.set('n', '<leader>fc', builtin.grep_string, { desc = 'Find String' })


		local colors = require("catppuccin.palettes").get_palette('mocha')
		local TelescopeColor = {
			TelescopeMatching = { fg = colors.flamingo },
			TelescopeSelection = { fg = colors.text, bg = colors.surface0, bold = true },

			TelescopePromptPrefix = { bg = colors.surface0 },
			TelescopePromptNormal = { bg = colors.surface0 },
			TelescopeResultsNormal = { bg = colors.mantle },
			TelescopePreviewNormal = { bg = colors.mantle },
			TelescopePromptBorder = { bg = colors.surface0, fg = colors.surface0 },
			TelescopeResultsBorder = { bg = colors.mantle, fg = colors.mantle },
			TelescopePreviewBorder = { bg = colors.mantle, fg = colors.mantle },
			TelescopePromptTitle = { bg = colors.pink, fg = colors.mantle },
			TelescopeResultsTitle = { fg = colors.mantle },
			TelescopePreviewTitle = { bg = colors.green, fg = colors.mantle },
		}

		for hl, col in pairs(TelescopeColor) do
			vim.api.nvim_set_hl(0, hl, col)
		end
	end
}
