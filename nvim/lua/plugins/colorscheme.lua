return {
  {
    "folke/tokyonight.nvim",
    config = function()
      vim.cmd.colorscheme "tokyonight"
    end
  },
  {
    "brenoprata10/nvim-highlight-colors",
    config = function()
      require("nvim-highlight-colors").setup({});
    end
  }
}
