return {
  "pwntester/octo.nvim",
  cmd = "Octo",
  opts = {
    -- or "fzf-lua" or "snacks" or "default"
    picker = "snacks",
    -- bare Octo command opens picker of commands
    enable_builtin = true,
  },
  dependencies = {
    "nvim-lua/plenary.nvim",
    "folke/snacks.nvim",
    -- OR "nvim-telescope/telescope.nvim",
    -- OR "ibhagwan/fzf-lua",
    "nvim-tree/nvim-web-devicons",
  },
}
