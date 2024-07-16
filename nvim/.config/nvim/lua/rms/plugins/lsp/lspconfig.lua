return {
	'neovim/nvim-lspconfig',
	event = { 'BufReadPre', 'BufNewFile' },
	dependencies = {
		'hrsh7th/cmp-nvim-lsp',
		'williamboman/mason.nvim',
		'Hoffs/omnisharp-extended-lsp.nvim',
		'Decodetalkers/csharpls-extended-lsp.nvim',
		{ 'antosha417/nvim-lsp-file-operations', config = true },
	},
	config = function()
		local lspconfig = require('lspconfig')
		local cmp_nvim_lsp = require('cmp_nvim_lsp')

		local function lsp_highlight_document(client)
			local illuminate = require('illuminate')
			illuminate.on_attach(client)
		end

		local function lsp_keymaps(bufnr)
			local opts = { noremap = true, silent = true, buffer = bufnr }
			vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
			vim.keymap.set('n', 'gd', '<cmd>Telescope lsp_definitions<CR>', opts)
			vim.keymap.set('n', 'gT', '<cmd>Telescope lsp_type_definitions<CR>', opts)
			vim.keymap.set('n', 'gr', '<cmd>Telescope lsp_references<cr>', opts)
			vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
			vim.keymap.set('n', 'gi', '<cmd>Telescope lsp_implementations<CR>', opts)
			vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
			vim.keymap.set('n', '<C-s>', vim.lsp.buf.signature_help, opts)
			vim.keymap.set('n', '<leader>D', '<cmd>Telescope diagnostics bufnr=0<CR>', opts)
			vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, opts)
			vim.keymap.set('n', '<leader>gf', function()
				vim.lsp.buf.format({
					async = true,
					filter = function(client) return client.name ~= 'tsserver' end
				})
			end, opts)
			-- vim.keymap.set('n', '<leader>dn', vim.diagnostic.goto_next, opts)
			-- vim.keymap.set('n', '<leader>dp', vim.diagnostic.goto_prev, opts)
		end

		vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
			border = "rounded",
		})

		local on_attach = function(client, bufnr)
			lsp_keymaps(bufnr)
			lsp_highlight_document(client)
		end

		local signs = { Error = ' ', Warn = ' ', Hint = '󰠠 ', Info = ' ' }
		for type, icon in pairs(signs) do
			local hl = 'DiagnosticSign' .. type
			vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = '' })
		end

		local capabilities = cmp_nvim_lsp.default_capabilities()

		-- local serversWithDefaultConfig = { 'eslint', 'tsserver', 'tailwindcss', 'omnisharp', 'csharp_ls' }
		local serversWithDefaultConfig = { 'biome', 'tsserver', 'tailwindcss', 'eslint', 'astro', 'jsonls', 'yamlls' }

		for _, lsp in ipairs(serversWithDefaultConfig) do
			lspconfig[lsp].setup({
				capabilities = capabilities,
				on_attach = on_attach,
			})
		end

		-- lspconfig.csharp_ls.setup({
		-- 	capabilities = capabilities,
		-- 	on_attach = on_attach,
		-- 	handlers = {
		-- 		["textDocument/definition"] = require('csharpls_extended').handler,
		-- 		["textDocument/typeDefinition"] = require('csharpls_extended').handler,
		-- 	},
		-- })

		lspconfig['omnisharp'].setup({
			capabilities = capabilities,
			on_attach = function(client, bufnr)
				on_attach(client, bufnr)
				local opts = { noremap = true, silent = true, buffer = bufnr }
				vim.keymap.set('n', 'gd', "<cmd>lua require('omnisharp_extended').telescope_lsp_definition()<cr>", opts)
				vim.keymap.set('n', 'gT', "<cmd>lua require('omnisharp_extended').telescope_lsp_type_definition()<cr>", opts)
				vim.keymap.set('n', 'gr', "<cmd>lua require('omnisharp_extended').telescope_lsp_references()<cr>", opts)
				vim.keymap.set('n', 'gi', "<cmd>lua require('omnisharp_extended').telescope_lsp_implementation()<cr>", opts)
			end,
			cmd = { '/Users/rms/.local/share/nvim/mason/bin/omnisharp' },
			-- filetypes = { 'cs' },
			root_dir = lspconfig.util.root_pattern('*.sln', '*.csproj', 'project.json', '.git'),
			-- handlers = { ['textDocument/definition'] = require('omnisharp_extended').handler },
		})

		lspconfig['lua_ls'].setup({
			capabilities = capabilities,
			on_attach = on_attach,
			settings = { -- custom settings for lua
				Lua = {
					-- make the language server recognize "vim" global
					diagnostics = {
						globals = { 'vim' },
					},
					workspace = {
						-- make language server aware of runtime files
						library = {
							[vim.fn.expand('$VIMRUNTIME/lua')] = true,
							[vim.fn.stdpath('config') .. '/lua'] = true,
						},
					},
				},
			},
		})

		lspconfig['powershell_es'].setup({
			bundle_path = vim.fn.stdpath('data') .. '/mason/packages/powershell-editor-services/'
		})
	end
}
