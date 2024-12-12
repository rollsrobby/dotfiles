return {
  {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    opts = {
      -- bigfile = { enabled = true },
      -- notifier = { enabled = true },
      -- quickfile = { enabled = true },
      lazygit = { enabled = true },
    },
    keys = {
      { "<leader>.",  function() Snacks.scratch() end,               desc = "Toggle Scratch Buffer" },
      { "<leader>S",  function() Snacks.scratch.select() end,        desc = "Select Scratch Buffer" },
      { "<leader>n",  function() Snacks.notifier.show_history() end, desc = "Notification History" },
      { "<leader>bd", function() Snacks.bufdelete() end,             desc = "Delete Buffer" },
      { "<leader>gB", function() Snacks.gitbrowse() end,             desc = "Git Browse" },
      { "<leader>gb", function() Snacks.git.blame_line() end,        desc = "Git Blame Line" },
      -- { "<leader>gf", function() Snacks.lazygit.log_file() end,      desc = "Lazygit Current File History" },
      { "<leader>gg", function() Snacks.lazygit() end,               desc = "Lazygit" },
      { "<leader>gl", function() Snacks.lazygit.log() end,           desc = "Lazygit Log (cwd)" },
      { "<leader>un", function() Snacks.notifier.hide() end,         desc = "Dismiss All Notifications" },
    }
  }
}
