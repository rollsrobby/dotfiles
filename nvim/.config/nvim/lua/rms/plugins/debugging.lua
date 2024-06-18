return {
	'mfussenegger/nvim-dap',
	dependencies = {
		{
			'rcarriga/nvim-dap-ui',
			dependencies = { 'nvim-neotest/nvim-nio' },
		},
		{
			"microsoft/vscode-js-debug",
			-- After install, build it and rename the dist directory to out
			build = "npm install --legacy-peer-deps --no-save && npx gulp vsDebugServerBundle && rm -rf out && mv dist out",
			version = "1.*",
		},
		{
			"mxsdev/nvim-dap-vscode-js",
			config = function()
				---@diagnostic disable-next-line: missing-fields
				require("dap-vscode-js").setup({
					-- Path of node executable. Defaults to $NODE_PATH, and then "node"
					-- node_path = "node",

					-- Path to vscode-js-debug installation.
					debugger_path = vim.fn.resolve(vim.fn.stdpath("data") .. "/lazy/vscode-js-debug"),

					-- Command to use to launch the debug server. Takes precedence over "node_path" and "debugger_path"
					-- debugger_cmd = { "js-debug-adapter" },

					-- which adapters to register in nvim-dap
					adapters = {
						"chrome",
						"pwa-node",
						"pwa-chrome",
						"pwa-msedge",
						"pwa-extensionHost",
						"node-terminal",
					},

					-- Path for file logging
					-- log_file_path = "(stdpath cache)/dap_vscode_js.log",

					-- Logging level for output to file. Set to false to disable logging.
					-- log_file_level = false,

					-- Logging level for output to console. Set to false to disable console output.
					-- log_console_level = vim.log.levels.ERROR,
				})
			end,
		},
	},
	config = function()
		local dap = require('dap')
		local dapui = require('dapui')
		local js_based_languages = { "typescript", "javascript", "typescriptreact", "javascriptreact" };

		vim.keymap.set('n', '<leader>db', function() dap.toggle_breakpoint() end, {})
		vim.keymap.set('n', '<leader>dc', function()
			-- if vim.fn.filereadable(".vscode/launch.json") then
			-- 	local dap_vscode = require("dap.ext.vscode")
			-- 	dap_vscode.load_launchjs(nil, {
			-- 		["pwa-node"] = js_based_languages,
			-- 		["chrome"] = js_based_languages,
			-- 		["pwa-chrome"] = js_based_languages,
			-- 		["node-terminal"] = js_based_languages,
			-- 	})
			-- end
			dap.continue()
		end, {})
		vim.keymap.set('n', '<leader>dn', function() dap.step_over() end, {})
		vim.keymap.set('n', '<leader>dO', function() dap.step_out() end, {})
		vim.keymap.set('n', '<leader>di', function() dap.step_into() end, {})
		vim.keymap.set('n', '<leader>ds', function() dap.stop() end, {})
		vim.keymap.set('n', '<leader>dq', function()
			dap.disconnect({ terminateDebugger = true })
			dapui.close()
		end, {})
		vim.keymap.set('n', '<leader>dt', function() dapui.toggle() end, {})

		vim.fn.sign_define('DapStopped', { text = '󰁕 ', texthl = "e0af68", linehl = "373640" })
		vim.fn.sign_define('DapBreakpoint', { text = ' ' })
		vim.fn.sign_define('DapBreakpointCondition', { text = ' ' })
		vim.fn.sign_define('DapBreakpointRejected', { text = ' ', texthl = 'db4b4b' })
		vim.fn.sign_define('DapLogPoint', { text = '.>' })


		dap.adapters.coreclr = {
			type = 'executable',
			command = '/Users/rms/.local/share/nvim/mason/bin/netcoredbg',
			arg = { '--interpreter=vscode' }
		}

		-- dap.configurations.cs = {
		-- 	{
		-- 		typ = 'coreclr',
		-- 		name = 'NetCoreDbg: Launch',
		-- 		request = 'launch',
		-- 		cwd = '${fileDirname}',
		-- 		program = function()
		-- 			return vim.fn.input('Path to dll ', vim.fn.getcwd() .. '/bin/Debug', 'file')
		-- 		end,
		-- 	}
		-- }

		dap.configurations.cs = {
			{
				typ = 'coreclr',
				name = 'launch - netcoredbg',
				request = 'launch',
				program = function()
					return vim.fn.input('Path to dll ', vim.fn.getcwd() .. '/bin/Debug', 'file')
				end,
			}
		}

		for _, language in ipairs(js_based_languages) do
			dap.configurations[language] = {
				-- Debug nodejs processes (make sure to add --inspect when you run the process)
				{
					type = "pwa-node",
					request = "attach",
					name = "Attach",
					processId = require("dap.utils").pick_process,
					cwd = function()
						return vim.fn.input('Working directory: ', vim.fn.getcwd(), 'file')
					end,
					port = 9230,
					sourceMaps = true,
				},
				{
					type = "pwa-node",
					request = "launch",
					name = "Launch file",
					program = "${file}",
					cwd = vim.fn.getcwd(),
					sourceMaps = true,
				},
				-- Debug web applications (client side)
				{
					type = "pwa-chrome",
					request = "launch",
					name = "Launch & Debug Chrome",
					url = function()
						local co = coroutine.running()
						return coroutine.create(function()
							vim.ui.input({
								prompt = "Enter URL: ",
								default = "http://localhost:3000",
							}, function(url)
								if url == nil or url == "" then
									return
								else
									coroutine.resume(co, url)
								end
							end)
						end)
					end,
					webRoot = vim.fn.getcwd(),
					protocol = "inspector",
					sourceMaps = true,
					userDataDir = false,
				},
			}
		end

		-- dap.setup({})
		dapui.setup({})

		dap.listeners.before.attach.dapui_config = function()
			dapui.open()
		end

		dap.listeners.before.launch.dapui_config = function()
			dapui.open()
		end

		dap.listeners.before.event_terminated.dapui_config = function()
			dapui.close()
		end

		dap.listeners.before.event_exited.dapui_config = function()
			dapui.close()
		end
	end
}