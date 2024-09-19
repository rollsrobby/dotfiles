local api = vim.api

local cursorGrp = api.nvim_create_augroup("CursorLine", { clear = true })
api.nvim_create_autocmd({ "InsertLeave", "WinEnter" }, {
  pattern = "*",
  command = "set cursorline",
  group = cursorGrp,
})
api.nvim_create_autocmd(
  { "InsertEnter", "WinLeave" },
  { pattern = "*", command = "set nocursorline", group = cursorGrp }
)
api.nvim_create_autocmd("FileType", {
  pattern = "cs",
  callback = function()
    vim.opt_local.tabstop = 4          -- Number of spaces that a <Tab> counts for
    vim.opt_local.softtabstop = 4      -- Number of spaces that a <Tab> counts for while editing
    vim.opt_local.shiftwidth = 4       -- Number of spaces to use for each step of (auto)indent
    vim.opt_local.expandtab = true     -- Convert tabs to spaces
  end,
})
