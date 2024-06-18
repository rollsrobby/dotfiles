return {
	'williamboman/mason.nvim',
	dependencies = {
		'williamboman/mason-lspconfig.nvim',
		'Hoffs/omnisharp-extended-lsp.nvim'
	},
	config = function()
		local mason = require('mason')
		mason.setup({
			ui = {
				icons = {
					package_installed = "✓",
					package_pending = "➜",
					package_uninstalled = "✗",
				},
			},
		})

		local omnisharp_attach = function(_, bufnr)
			local opts = { noremap = true, silent = true, buffer = bufnr }
			vim.keymap.set('n', 'gd', "<cmd>lua require('omnisharp_extended').telescope_lsp_definition()<cr>", opts)
			vim.keymap.set('n', 'gT', "<cmd>lua require('omnisharp_extended').telescope_lsp_type_definition()<cr>", opts)
			vim.keymap.set('n', 'gr', "<cmd>lua require('omnisharp_extended').telescope_lsp_references()<cr>", opts)
			vim.keymap.set('n', 'gi', "<cmd>lua require('omnisharp_extended').telescope_lsp_implementation()<cr>", opts)
			vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
			vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
			vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
			vim.keymap.set('n', '<C-s>', vim.lsp.buf.signature_help, opts)
			vim.keymap.set('n', '<leader>D', '<cmd>Telescope diagnostics bufnr=0<CR>', opts)
			vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, opts)
			vim.keymap.set('n', '<leader>gf', function()
				vim.lsp.buf.format({ async = true })
			end, opts)
		end

		local mason_lspconfig = require('mason-lspconfig')
		mason_lspconfig.setup({
			ensure_installed = {
				'csharp_ls', 'omnisharp', 'lua_ls', 'powershell_es', 'tsserver', 'tailwindcss', 'astro', 'eslint', 'jsonls',
			},
			handlers = {
				omnisharp = function()
					require('lspconfig').omnisharp.setup({
						handlers = { ['textDocument/definition'] = require('omnisharp_extended').handler },
						on_attach = omnisharp_attach,
						capabilities = require('cmp_nvim_lsp').default_capabilities(),
						cmd = { '/Users/rms/.local/share/nvim/mason/bin/omnisharp' },
						filetypes = { 'cs' },
						-- root_dir = function() return vim.loop.cwd() end
						root_dir = require('lspconfig').util.root_pattern('*.sln', '*.csproj', 'project.json', '.git'),
					})
				end
			}
		})
	end
}
