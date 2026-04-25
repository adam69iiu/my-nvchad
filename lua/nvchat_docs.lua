local M = {}

local telescope = require "telescope.builtin"

local lang_map = {
  bash = "bash",
  go = "go",
  py = "python",
  python = "python",
  sh = "bash",
  zsh = "bash",
}

local function docs_root()
  return "/Users/adam/devproject/obsidian/knowledge/better-call-soul/mydocs"
end

local function existing_dir(path)
  return vim.fn.isdirectory(path) == 1
end

local function scoped_dir(name)
  local root = docs_root()
  local dir = root .. "/" .. name

  if existing_dir(dir) then
    return dir, name
  end

  return nil, name
end

local function read_lines(path)
  return vim.fn.readfile(path)
end

local function open_preview(path, markers, needle)
  local lines = read_lines(path)

  vim.cmd.edit(vim.fn.fnameescape(path))

  local buf = vim.api.nvim_get_current_buf()
  vim.bo[buf].bufhidden = "wipe"

  if needle ~= "" then
    local lowered = needle:lower()
    for i, line in ipairs(lines) do
      if #markers == 0 and line:lower():find(lowered, 1, true) then
        vim.api.nvim_win_set_cursor(0, { i, 0 })
        vim.cmd "normal! zt"
        break
      end

      for _, marker in ipairs(markers) do
        if line:find(marker, 1, true) and line:lower():find(lowered, 1, true) then
          vim.api.nvim_win_set_cursor(0, { i, 0 })
          vim.cmd "normal! zt"
          break
        end
      end
    end
  end

  vim.keymap.set("n", "q", "<cmd>bd<CR>", { buffer = buf, nowait = true, silent = true })
end

local function open_selected_in_float(prompt_bufnr, markers, needle)
  local actions = require "telescope.actions"
  local action_state = require "telescope.actions.state"
  local entry = action_state.get_selected_entry(prompt_bufnr)
  local query = action_state.get_current_line()

  actions.close(prompt_bufnr)

  if not entry or not entry.path then
    return
  end

  open_preview(entry.path, markers, query ~= "" and query or needle)
end

local function grep_scope(opts)
  local term = vim.fn.expand "<cword>"
  local dir, scope = scoped_dir(opts.scope)

  if not dir then
    vim.notify("Docs directory not found under: " .. docs_root(), vim.log.levels.WARN)
    return
  end

  telescope.live_grep {
    prompt_title = opts.title_prefix .. " " .. scope,
    search_dirs = { dir },
    default_text = term,
    additional_args = function()
      return { "-i" }
    end,
    attach_mappings = function(_, map)
      map("i", "<CR>", function(prompt_bufnr)
        open_selected_in_float(prompt_bufnr, opts.markers, term)
      end)
      map("n", "<CR>", function(prompt_bufnr)
        open_selected_in_float(prompt_bufnr, opts.markers, term)
      end)
      return true
    end,
  }
end

function M.search_all()
  grep_scope {
    title_prefix = "Search docs",
    scope = "myOS",
    markers = {},
  }
end

function M.search_index()
  grep_scope {
    title_prefix = "Search index",
    scope = "myOS",
    markers = {},
  }
end

function M.search_detailed()
  grep_scope {
    title_prefix = "Search detailed",
    scope = "general/_detailed",
    markers = {},
  }
end

function M.search_ios()
  grep_scope {
    title_prefix = "Search iOS docs",
    scope = "ios",
    markers = {},
  }
end

function M.search_go()
  grep_scope {
    title_prefix = "Search Go docs",
    scope = "go",
    markers = {},
  }
end

function M.find_files()
  local dir, scope = scoped_dir("myOS")

  if not dir then
    vim.notify("Docs directory not found under: " .. docs_root(), vim.log.levels.WARN)
    return
  end

  telescope.find_files {
    prompt_title = "Docs files " .. scope,
    cwd = dir,
  }
end

return M
