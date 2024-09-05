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
        vim.keymap.set("n", "<leader>rr", "<cmd>Rest run<cr>", { desc = "Run request under the cursor" }),
        vim.keymap.set("n", "<leader>rl", "<cmd>Rest last<cr>", { desc = "Re-run last request" }),
      })
    end,
  }
}
