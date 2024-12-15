return {
	{
		"stevearc/oil.nvim",
		---@module 'oil',
		---@type oil.SetupOpts
		opts = {},
		depdencies = { { "echasnovski/mini.icons", opts = {} } },
		config = function()
			require("oil").setup()
			vim.keymap.set("n", "-","<cmd>Oil<cr>", { desc = "Open parent directory" })
		end
	}
}
