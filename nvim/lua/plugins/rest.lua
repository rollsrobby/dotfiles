return {
  {
    "rest-nvim/rest.nvim",
    config = function()
      require("rest-nvim").setup({
        ui = {
          keybinds = {
            prev = "P",
            next = "N",
          }
        },
        request = {
          skip_ssl_verification = true,
        },
        vim.keymap.set("n", "<leader>rr", ":vert belowright Rest run<cr>",
          { desc = "Run request under the cursor", silent = true }),
        vim.keymap.set("n", "<leader>rl", ":vert belowright Rest last<cr>",
          { desc = "Re-run last request", silent = true }),
      })
    end,
  }
}
