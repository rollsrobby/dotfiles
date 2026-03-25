return {
  settings = {
    tailwindCSS = {
      experimental = {
        configFile = {
          ["packages/ui/src/styles/globals.css"] = {
            "packages/ui/src/**",
            "apps/admin/src/**",
            "apps/teams-app/src/**",
          },
        },
      },
    },
  },
}
