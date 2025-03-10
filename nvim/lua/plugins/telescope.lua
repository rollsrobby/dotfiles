return {
  {
    "nvim-telescope/telescope.nvim",
    tag = '0.1.8',
    dependencies = {
      'nvim-lua/plenary.nvim',
      { "nvim-telescope/telescope-fzf-native.nvim", build = "make" }
    },
    config = function()
      require("telescope").setup({
        pickers = {
          find_files = {
            theme = "ivy"
          },
          git_files = {
            theme = "ivy"
          },
          diagnostics = {
            theme = "ivy"
          },
          live_grep = {
            theme = "ivy"
          },
        },
        extensions = {
          fzf = {}
        }
      })

      require("telescope").load_extension("fzf")
      local builtin = require("telescope.builtin")
      vim.keymap.set("n", "<leader>fd", builtin.find_files, { desc = "Find in directory" })
      vim.keymap.set("n", "<leader>fn", function()
        builtin.find_files({
          cwd = vim.fn.stdpath("config")
        })
      end, { desc = "Find in nvim config dir" })
      vim.keymap.set("n", '<leader>ff', builtin.git_files, { desc = "Find git Files" })
      -- vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Grep in files' })
      vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Find Buffers" })
      vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "Find help tags" })
      -- vim.keymap.set("n", "<leader>fx", builtin.diagnostics, { desc = "Find Diagnostics" })
      vim.keymap.set("n", "<leader>fc", builtin.grep_string, { desc = "Find String" })

      require("plugins.telescope.multigrep").setup(require('telescope.themes').get_ivy())
    end
  }
}
