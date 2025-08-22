return {
  {
    "nvim-treesitter/nvim-treesitter",
    dependencies = { "OXY2DEV/markview.nvim" },
    build = ":TSUpdate",
    branch = "master",
    lazy = false,
    config = function()
      local configs = require("nvim-treesitter.configs")

      configs.setup({
        ensure_installed = { "lua", "json", "vim", "vimdoc", "query", "javascript", "html", "typescript", "http", "tsx", "c_sharp", "css", "bash", "dockerfile", "xml", "astro" },
        sync_install = false,
        auto_install = false,
        ignore_install = {},
        highlight = { enable = true },
        indent = { enable = true },
      })
    end
  }
}
