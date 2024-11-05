return {
	'nvim-treesitter/nvim-treesitter',
	build = ':TSUpdate',
	config = function()
		local configs = require('nvim-treesitter.configs')
		configs.setup {
			ensure_installed = { 'c_sharp', 'lua', 'typescript', 'javascript', 'json', 'html', 'css', 'bash', 'tsx', 'dockerfile', 'vimdoc', 'http', 'xml', 'graphql'},
			highlight = {
				enable = true,
			},
			indent = {
				enable = true,
			},
		}
	end
}
