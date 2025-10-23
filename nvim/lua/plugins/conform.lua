return {
  {
    'stevearc/conform.nvim',
    opts = {
      formatters_by_ft = {
        lua = { "stylua" },
        javascript = { "biome", "biome-check", "biome-organize-imports" },
        javascriptreact = { "biome", "biome-check", "biome-organize-imports" },
        typescript = { "biome", "biome-check", "biome-organize-imports" },
        typescriptreact = { "biome-check" },
        css = { "biome" },
        json = { "biome", "jq" },
        jsonc = { "biome" },
        html = { "biome" }
      },
      format_on_save = {
        -- These options will be passed to conform.format()
        timeout_ms = 500,
        lsp_format = "fallback",
      },
    },
    keys = {
      {
        "<leader>gf",
        function()
          require("conform").format({ async = true, lsp_format = "fallback" })
        end,
        mode = "",
        desc = "[F]ormat buffer",
      },
    },
  }
}
