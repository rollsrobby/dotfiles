return {
	'prettier/vim-prettier',
	build = 'pnpm install -g prettier',
	config = function()
		vim.api.nvim_create_augroup('BufWritePreFormatter', {})
		vim.api.nvim_create_autocmd('BufWritePre',
			{
				command = 'Prettier',
				pattern = '*.js,*.jsx,*.ts,*.tsx,*.css,*.scss,*.json,*.graphql,*.md',
				group = 'BufWritePreFormatter'
			})
	end
}
