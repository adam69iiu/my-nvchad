-- This file needs to have same structure as nvconfig.lua
-- Match the docs to the NvChad branch loaded in init.lua (currently v2.5).
-- Please read that file to know all available options :(

---@type ChadrcConfig
local M = {}

M.base46 = {
  theme = "jabuti",
  -- transparency = true,

  hl_override = {
    Search = { fg = "#cdd6f4", bg = "#313244" },
    IncSearch = { fg = "#1e1e2e", bg = "#f9e2af" },
    CurSearch = { fg = "#1e1e2e", bg = "#f9e2af" },
    Visual = { bg = "#313244" },
    CursorLine = { bg = "#24273a" },
    MatchParen = { fg = "#cdd6f4", bg = "#45475a", bold = true },
    CmpItemAbbrMatch = { fg = "#83a598", bg = "NONE", bold = false, underline = false },
    CmpItemAbbrMatchFuzzy = { fg = "#8ec07c", bg = "NONE", bold = false, underline = false, italic = false },
    BlinkCmpMenuSelection = { fg = "#ebdbb2", bg = "#3c3836", bold = false },
    LspReferenceText = { bg = "#313244" },
    LspReferenceRead = { bg = "#313244" },
    LspReferenceWrite = { bg = "#313244" },
  },
}

-- M.nvdash = { load_on_startup = true }
-- M.ui = {
--       tabufline = {
--          lazyload = false
--      }
-- }

return M
