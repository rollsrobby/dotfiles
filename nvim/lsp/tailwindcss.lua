local stylesheet = 'packages/ui/src/styles/globals.css'

return {
  before_init = function(params, config)
    config.settings = vim.tbl_deep_extend('keep', config.settings or {}, {
      editor = {
        tabSize = vim.lsp.util.get_effective_tabstop(),
      },
    })

    local root = params.rootUri and vim.uri_to_fname(params.rootUri)
    if not root then
      return
    end

    local stylesheet_path = vim.fs.joinpath(root, stylesheet)
    if not vim.uv.fs_stat(stylesheet_path) then
      return
    end

    config.settings = vim.tbl_deep_extend('force', config.settings, {
      tailwindCSS = {
        experimental = {
          configFile = {
            [stylesheet] = {
              'packages/ui/src/**',
              'apps/admin/src/**',
              'apps/teams-app/src/**',
            },
          },
        },
      },
    })
  end,
}
-- return {
--   settings = {
--     tailwindCSS = {
--       experimental = {
--         configFile = {
--           ["packages/ui/src/styles/globals.css"] = {
--             "packages/ui/src/**",
--             "apps/admin/src/**",
--             "apps/teams-app/src/**",
--           },
--         },
--       },
--     },
--   },
-- }
