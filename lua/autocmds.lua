require "nvchad.autocmds"

local api = vim.api

-- Markdown: clear the orange foreground that covers treesitter injection highlights
-- (runs after base46 theme loads, so these win)
vim.api.nvim_set_hl(0, "@markup.raw.block", {})
vim.api.nvim_set_hl(0, "@markup.raw.block.markdown", {})
vim.api.nvim_set_hl(0, "@markup.raw.markdown_inline", { fg = "#a6e3a1" })

-- Markdown: conceallevel >= 1 required for render-markdown.nvim to work
api.nvim_create_autocmd("FileType", {
  pattern = "markdown",
  callback = function()
    vim.opt_local.conceallevel = 2
  end,
})

local autoread_group = api.nvim_create_augroup("UserAutoRead", { clear = true })

api.nvim_create_autocmd({ "BufEnter", "CursorHold", "CursorHoldI", "FocusGained" }, {
  group = autoread_group,
  command = "checktime",
})

api.nvim_create_autocmd("FileChangedShellPost", {
  group = autoread_group,
  callback = function()
    vim.notify("File reloaded from disk", vim.log.levels.INFO, { title = "autoread" })
  end,
})
