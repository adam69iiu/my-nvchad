require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set
local ok, term = pcall(require, "nvchad.term")
local ok_docs, docs = pcall(require, "nvchat_docs")

map("n", ";", ":", { desc = "CMD enter command mode" })
map("n", "<leader>pp", "ggVGy", { desc = "Copy entire file" })
-- map("i", "jk", "<ESC>")
map("n", "<leader>e", "<cmd>Neotree toggle filesystem reveal left<CR>", { desc = "Toggle file explorer" })
map("i", "jj", "<ESC>", { desc = "Exit to normal mode" })
map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")
vim.keymap.set("t", "jj", [[<C-\><C-n>]], { desc = "Exit terminal mode" })

map("n", "<A-j>", "<cmd>m .+1<CR>==", { desc = "Move line down" })
map("n", "<A-k>", "<cmd>m .-2<CR>==", { desc = "Move line up" })
map("i", "<A-j>", "<Esc><cmd>m .+1<CR>==gi", { desc = "Move line down" })
map("i", "<A-k>", "<Esc><cmd>m .-2<CR>==gi", { desc = "Move line up" })
map("v", "<A-j>", ":m '>+1<CR>gv=gv", { desc = "Move selection down" })
map("v", "<A-k>", ":m '<-2<CR>gv=gv", { desc = "Move selection up" })

-- macOS terminals sometimes send Option-j/k as literal characters instead of <A-j>/<A-k>
map("n", "˚", "<cmd>m .+1<CR>==", { desc = "Move line down" })
map("n", "∆", "<cmd>m .-2<CR>==", { desc = "Move line up" })
map("i", "˚", "<Esc><cmd>m .+1<CR>==gi", { desc = "Move line down" })
map("i", "∆", "<Esc><cmd>m .-2<CR>==gi", { desc = "Move line up" })
map("v", "˚", ":m '>+1<CR>gv=gv", { desc = "Move selection down" })
map("v", "∆", ":m '<-2<CR>gv=gv", { desc = "Move selection up" })

if ok_docs then
	map("n", "<leader>ii", docs.search_all, { desc = "Search local docs" })
	map("n", "<leader>ig", docs.search_go, { desc = "Search Go docs" })
	map("n", "<leader>is", docs.search_ios, { desc = "Search iOS docs" })
	map("n", "<leader>io", docs.search_index, { desc = "Search docs index" })
	map("n", "<leader>id", docs.search_detailed, { desc = "Search detailed docs" })
	map("n", "<leader>if", docs.find_files, { desc = "Find docs files" })
end

if ok then
	map("n", "<leader>h", function()
		term.toggle { pos = "sp", id = "htoggleTerm" }
	end, { desc = "Toggle horizontal terminal" })

	map("t", "<leader>h", [[<C-\><C-n><cmd>lua require("nvchad.term").toggle({ pos = "sp", id = "htoggleTerm" })<CR>]], {
		desc = "Toggle horizontal terminal",
	})

	map("n", "<leader>v", function()
		term.toggle { pos = "vsp", id = "vtoggleTerm" }
	end, { desc = "Toggle vertical terminal" })

	map("t", "<leader>v", [[<C-\><C-n><cmd>lua require("nvchad.term").toggle({ pos = "vsp", id = "vtoggleTerm" })<CR>]], {
		desc = "Toggle vertical terminal",
	})
end
--
--
-- Nvim DAP
map("n", "<Leader>dl", "<cmd>lua require'dap'.step_into()<CR>", { desc = "Debugger step into" })
map("n", "<Leader>dj", "<cmd>lua require'dap'.step_over()<CR>", { desc = "Debugger step over" })
map("n", "<Leader>dk", "<cmd>lua require'dap'.step_out()<CR>", { desc = "Debugger step out" })
map("n", "<Leader>dc", "<cmd>lua require'dap'.continue()<CR>", { desc = "Debugger continue" })
map("n", "<Leader>db", "<cmd>lua require'dap'.toggle_breakpoint()<CR>", { desc = "Debugger toggle breakpoint" })
map(
	"n",
	"<Leader>dd",
	"<cmd>lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>",
	{ desc = "Debugger set conditional breakpoint" }
)
map("n", "<Leader>de", "<cmd>lua require'dap'.terminate()<CR>", { desc = "Debugger reset" })
map("n", "<Leader>dr", "<cmd>lua require'dap'.run_last()<CR>", { desc = "Debugger run last" })

-- rustaceanvim
map("n", "<Leader>dt", "<cmd>lua vim.cmd('RustLsp testables')<CR>", { desc = "Debugger testables" })
