require("nvchad.configs.lspconfig").defaults()

vim.lsp.config("sourcekit", {
  cmd = { "sourcekit-lsp" },
  filetypes = { "swift" },
  root_markers = { "Package.swift", ".git", "*.xcodeproj", "*.xcworkspace" },
})

vim.lsp.config("gopls", {
  cmd = { "gopls" },
  filetypes = { "go", "gomod", "gowork", "gotmpl" },
  root_markers = { "go.work", "go.mod", ".git" },
})

vim.lsp.config("sqls", {
  cmd = { "sqls" },
  filetypes = { "sql" },
  root_markers = { ".git" },
})

local servers = { "html", "cssls", "sourcekit", "gopls", "sqls" }
vim.lsp.enable(servers)

-- read :h vim.lsp.config for changing options of lsp servers 
