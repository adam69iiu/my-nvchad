local options = {
  formatters_by_ft = {
    go = { "goimports", "gofumpt" },
    c = { "clang-format" },
    cpp = { "clang-format" },
    sql = { "sql_formatter" },
    lua = { "stylua" },
    -- css = { "prettier" },
    -- html = { "prettier" },
  },

  format_on_save = function(bufnr)
    local ft = vim.bo[bufnr].filetype
    if ft == "go" or ft == "c" or ft == "cpp" then
      return {
        timeout_ms = 500,
        lsp_format = "fallback",
      }
    end
  end,
}

return options
