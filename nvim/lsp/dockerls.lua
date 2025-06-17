-- as seen on https://github.com/neovim/nvim-lspconfig/tree/master/lsp


return {
  cmd = { 'docker-langserver', '--stdio' },
  filetypes = { 'dockerfile' },
  root_markers = { 'Dockerfile' },
}
