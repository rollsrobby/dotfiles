return {
  {
    "rest-nvim/rest.nvim",
    ft = "http",
    build = false,
    dependencies = {
      "j-hui/fidget.nvim",
      "nvim-neotest/nvim-nio",
      "nvim-treesitter/nvim-treesitter",
      {
        -- Lazy.nvim does not recognize this library's rocksfile, so add it
        -- to package path manually.
        "manoelcampos/xml2lua",
        config = function(plugin)
          package.path = package.path .. ";" .. plugin.dir .. "/?.lua"
        end,
      },
      "lunarmodules/lua-mimetypes"
    },
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
