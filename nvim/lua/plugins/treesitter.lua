return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
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
