-- This file is mostly for keymaps that don't use plugins, the ones that do should go in the
--  corresponding plugin folder.

-- INFO: To define which-key keymap groups and icons go to: ../plugins/which-key.lua
-- INFO: To change descriptions for existing keymaps go to: ../plugins/which-key.lua
-- INFO: For LSP keymaps that depend on the buffer (buffer-local) go to: ../utils/lsp.lua
-- INFO: For nvim-tree buffer-local keymaps go to: ../plugins/tree.lua
-- INFO: For completion (cmp) mappings go to: ../plugins/cmp.lua

local keymap = vim.keymap.set

--== Native Neovim keymaps

-- Center screen when jumping
keymap("n", "n", "nzzzv", { desc = "Next search result (centered)" })
keymap("n", "N", "Nzzzv", { desc = "Previous search result (centered)" })
keymap("n", "<C-d>", "<C-d>zz", { desc = "Half page down (centered)" })
keymap("n", "<C-u>", "<C-u>zz", { desc = "Half page up (centered)" })

-- Better window navigation
keymap("n", "<C-h>", "<C-w>h", { desc = "Move to left window" })
keymap("n", "<C-j>", "<C-w>j", { desc = "Move to bottom window" })
keymap("n", "<C-k>", "<C-w>k", { desc = "Move to top window" })
keymap("n", "<C-l>", "<C-w>l", { desc = "Move to right window" })

-- Better indenting in visual mode
keymap("v", "<", "<gv", { desc = "Indent left and reselect" })
keymap("v", ">", ">gv", { desc = "Indent right and reselect" })

-- Better J behavior
keymap("n", "J", "mzJ`z", { desc = "Join lines and keep cursor position" })

-- Yank to and paste from the system clipboard.
keymap({ "n", "v", "x" }, "<leader>y", '"+y', { desc = "Yank to clipboard with motions" })
keymap("n", "<leader>Y", 'v$"+y', { desc = "Yank to clipboard until the end of the line" })
keymap("n", "<leader>p", '"+p', { desc = "Paste from clipboard" })
keymap("n", "<leader>P", '"+P', { desc = "Paste from clipboard before" })

-- Delete and paste without yanking (only on Visual mode so it doesn't interfere with other keymaps)
keymap("v", "<leader>d", '"_d', { desc = "Delete without yanking" })
keymap("v", "<leader>p", '"_dP', { desc = "Paste without yanking" })

-- Clear search highlighting by pressing <Esc> in normal mode.
keymap("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- Removing default diagnostics jumping
vim.keymap.del("n", "[d")
vim.keymap.del("n", "]d")
vim.keymap.del("n", "[D")
vim.keymap.del("n", "]D")

--== which-key

-- Show global which-key keymaps.
-- Can also usually be reached by pressing backspace 1+ times in which-key.
keymap("n", "<leader>?g", function()
	require("which-key").show({ global = true })
end, { desc = "Global [<BS><BS>]" })
-- Show buffer-local keymaps (LSP, nvim-tree, ...).
keymap("n", "<leader>?l", function()
	require("which-key").show({ global = false })
end, { desc = "Buffer-local (LSP, nvim-tree, ...)" })

-- Make window keymaps keep <C-w> context, so I can easily change split sizes.
-- This can cause a which-key recursion error when resizing too much, but so can holding down 'y',
--  so whatever.
keymap("n", "<leader>w", function()
	require("which-key").show({ keys = "<C-w>", loop = true })
end, { desc = "+Window" })

--== nvim-tree
keymap("n", "<leader>tT", "<Cmd>NvimTreeFindFileToggle<CR>", { desc = "Tree (File Explorer)" })
keymap("n", "<leader>e", "<Cmd>NvimTreeFindFileToggle<CR>", { desc = "Tree (File Explorer)" })

--== undotree
keymap("n", "<leader>tu", function()
	vim.cmd.UndotreeToggle()
	vim.cmd.UndotreeFocus()
end, { desc = "Undotree" })
keymap("n", "<leader>u", function()
	vim.cmd.UndotreeToggle()
	vim.cmd.UndotreeFocus()
end, { desc = "Undotree" })

--== mini.notify
keymap("n", "<leader>n", function()
	require("mini.notify").show_history()
end, { desc = "Show notification history" })

--== TODO

-- 'to_fix_keywords' are the relevant keywords I usually care about.
local to_fix_keywords = { "TODO", "FIX", "FIXME" }

-- Search and toggle workspace TODOs
keymap("n", "<leader>stt", function()
	require("todo-comments.fzf").todo({ keywords = to_fix_keywords })
end, { desc = "To do and fix" })
keymap("n", "<leader>sta", "<cmd>TodoFzfLua<CR>", { desc = "All" })
keymap("n", "<leader>ttt", function()
	require("trouble").toggle({ mode = "todo", filter = { tag = to_fix_keywords } })
end, { desc = "To do and fix" })
keymap("n", "<leader>tta", function()
	require("trouble").toggle("todo")
end, { desc = "All" })

-- Jumps to TODOs, these replace tab jumps but I don't use tabs.
-- Doesn't work across files, but neither does diagnostics, so if I want that just use quickfix.
vim.keymap.set("n", "]t", function()
	require("todo-comments").jump_next({ keywords = to_fix_keywords })
end, { desc = "Todo" })
vim.keymap.set("n", "[t", function()
	require("todo-comments").jump_prev({ keywords = to_fix_keywords })
end, { desc = "Todo" })

--== auto-session
keymap("n", "<leader>\\s", "<cmd>AutoSession search<CR>", { desc = "Search" })
keymap("n", "<leader>\\w", "<cmd>AutoSession save<CR>", { desc = "Save" })
keymap("n", "<leader>\\r", "<cmd>AutoSession restore<CR>", { desc = "Restore" })
keymap("n", "<leader>\\d", "<cmd>AutoSession delete<CR>", { desc = "Delete" })
keymap("n", "<leader>\\D", "<cmd>AutoSession deletePicker<CR>", { desc = "Delete picker" })
keymap("n", "<leader>\\a", "<cmd>AutoSession toggle<CR>", { desc = "Toggle session autosave" })
keymap("n", "<leader>\\p", "<cmd>AutoSession purgeOrphaned<CR>", { desc = "Purge orphaned" })

--== Search
keymap("n", "<leader>ss", "<cmd>FzfLua builtin<CR>", { desc = "..." }) -- All FzfLua options
keymap("n", "<leader>sr", "<cmd>FzfLua resume<CR>", { desc = "Resume search" })
keymap("n", "<leader>sf", "<cmd>FzfLua files<CR>", { desc = "Files" })
keymap("n", "<leader>sn", function()
	require("fzf-lua").files({
		cwd = vim.fn.stdpath("config"),
	})
end, { desc = "Neovim config" })
keymap("n", "<leader>si", function()
	require("fzf-lua").files({
		-- Basically add '--no-ignore' to the default value in
		--  https://github.com/ibhagwan/fzf-lua/blob/d59f857c76eb474ec00debcf043f14fd001805cc/lua/fzf-lua/defaults.lua#L523
		fd_opts = [[--color=never --type f --type l --exclude .git --no-ignore]],
	})
end, { desc = "Files (including in .gitignore)" })
keymap("n", "<leader>so", "<cmd>FzfLua oldfiles<CR>", { desc = "Oldfiles" })
keymap("n", "<leader>sF", "<cmd>FzfLua filetypes<CR>", { desc = "Select file type" })
keymap("n", "<leader>sg", "<cmd>FzfLua live_grep<CR>", { desc = "Live grep" })
keymap("n", "<leader>s/", "<cmd>FzfLua lgrep_curbuf<CR>", { desc = "Live grep current buffer" })
keymap("n", "<leader>sw", "<cmd>FzfLua grep_cword<CR>", { desc = "Grep word on cursor" })
keymap("n", "<leader>sb", "<cmd>FzfLua buffers<CR>", { desc = "Buffers" })
keymap("n", "<leader>sh", "<cmd>FzfLua helptags<CR>", { desc = "Help" })
keymap("n", "<leader>sc", "<cmd>FzfLua commands<CR>", { desc = "Commands" })
keymap("n", "<leader>sC", "<cmd>FzfLua command_history<CR>", { desc = "Command history" })
keymap("n", "<leader>sk", "<cmd>FzfLua keymaps<CR>", { desc = "Keymaps" })

--== Trouble
keymap("n", "<leader>tq", "<cmd>Trouble qflist toggle<CR>", { desc = "Quickfix list" })
-- https://stackoverflow.com/questions/20933836/what-is-the-difference-between-location-list-and-quickfix-list-in-vim
-- Basically a single file quickfix list.
-- keymap("n", "<leader>tl", "<cmd>Trouble loclist toggle<CR>", { desc = "Location list" })

--== Git
keymap("n", "]g", "<cmd>Gitsigns next_hunk<CR>", { desc = "Git hunk" })
keymap("n", "<leader>gn", "<cmd>Gitsigns next_hunk<CR>", { desc = "']g' Next hunk" })
keymap("n", "[g", "<cmd>Gitsigns prev_hunk<CR>", { desc = "Git hunk" })
keymap("n", "<leader>gp", "<cmd>Gitsigns prev_hunk<CR>", { desc = "'[g' Prev hunk" })

keymap("n", "<leader>gs", "<cmd>Gitsigns stage_hunk<CR>", { desc = "Stage hunk" })
keymap("n", "<leader>gS", "<cmd>Gitsigns stage_buffer<CR>", { desc = "Stage buffer" })
keymap("n", "<leader>gr", "<cmd>Gitsigns reset_hunk<CR>", { desc = "Reset hunk" })
keymap("n", "<leader>gR", "<cmd>Gitsigns reset_buffer<CR>", { desc = "Reset buffer" })
keymap("n", "<leader>gu", "<cmd>Gitsigns undo_stage_hunk<CR>", { desc = "Undo stage hunk" })

keymap("n", "<leader>gd", "<cmd>Gitsigns diffthis<CR>", { desc = "Diff" })
keymap("n", "<leader>gD", "<cmd>Gitsigns diffthis @<CR>", { desc = "Diff (last commit)" })

keymap("n", "<leader>gb", "<cmd>Gitsigns blame_line<CR>", { desc = "Blame" })

keymap("n", "<leader>gts", "<cmd>Gitsigns toggle_signs<CR>", { desc = "Signs" })
keymap("n", "<leader>gtd", "<cmd>Gitsigns toggle_deleted<CR>", { desc = "Deleted" })
keymap("n", "<leader>gtw", "<cmd>Gitsigns toggle_word_diff<CR>", { desc = "Word diff" })
keymap("n", "<leader>gtl", "<cmd>Gitsigns toggle_linehl<CR>", { desc = "Line highlight" })
keymap("n", "<leader>gtb", "<cmd>Gitsigns toggle_current_line_blame<CR>", { desc = "Current line blame" })

keymap({ "o", "x" }, "ig", "<cmd>Gitsigns select_hunk<CR>", { desc = "Git hunk" })
keymap({ "o", "x" }, "ag", "<cmd>Gitsigns select_hunk<CR>", { desc = "Git hunk" })

--== markview
keymap("n", "<leader>tm", "<cmd>Markview<CR>", { desc = "Markview" })

--== LSP

-- Rename the variable under the cursor.
--  Most Language Servers support renaming across files, etc.
keymap("n", "<leader>r", vim.lsp.buf.rename, { desc = "Rename" })
keymap("n", "<leader>lR", vim.lsp.buf.rename, { desc = "Rename" })

-- A combination of many of the keymaps below.
keymap("n", "<leader>lf", "<cmd>FzfLua lsp_finder<CR>", { desc = "Finder (definition, references, ...)" })

-- Jump to the definition of the word under the cursor. This is where
--  a variable was first declared, or where a function is defined, etc.
keymap("n", "<leader>ld", "<cmd>FzfLua lsp_definitions<CR>", { desc = "Definition" })

-- Find references for the word under the cursor.
keymap("n", "<leader>lr", "<cmd>FzfLua lsp_references<CR>", { desc = "References" })

-- Jump to the implementation of the word under the cursor.
-- Useful when the language has ways of declaring types without an actual implementation.
keymap("n", "<leader>li", "<cmd>FzfLua lsp_implementations<CR>", { desc = "Implementations" })

-- Jump to the type of the word under the cursor
-- Useful when I'm not sure what type a variable is and I want to see
--  the definition of its type, not where it was defined.
keymap("n", "<leader>lt", "<cmd>FzfLua lsp_typedefs<CR>", { desc = "Type definitions" })

-- Fuzzy find all the symbols in the current document.
--  Symbols are things like variables, functions, types, etc.
keymap("n", "<leader>ls", "<cmd>FzfLua lsp_document_symbols<CR>", { desc = "Document symbols" })

-- Fuzzy find all the symbols in the current workspace.
--  Similar to document symbols, except it searches over the entire project.
keymap("n", "<leader>lS", "<cmd>FzfLua lsp_workspace_symbols<CR>", { desc = "Workspace symbols" })

-- Execute a code action (to fix an error or other). Usually the cursor needs to be on top of an
--  error or a suggestion from the LSP for this to activate.
keymap("n", "<leader>la", "<cmd>FzfLua lsp_code_actions<CR>", { desc = "Code action" })

--  In C this would take me to the header
keymap("n", "<leader>lD", "<cmd>FzfLua lsp_declarations<CR>", { desc = "Declarations" })

-- Toggles
keymap(
	"n",
	"<leader>ts",
	"<cmd>Trouble lsp_document_symbols toggle focus=false multiline=false win.position=right<cr>",
	{ desc = "LSP Document Symbols" }
)
keymap(
	"n",
	"<leader>tl",
	"<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
	{ desc = "LSP definitions, references, ..." }
)
keymap("n", "<leader>th", function()
	vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
end, { desc = "Inlay hints" })
keymap("n", "<leader>tf", function()
	vim.g.autoformat = not vim.g.autoformat
end, { desc = "Formatting on save" })

--== Diagnostics
keymap("n", "[x", function()
	vim.diagnostic.jump({ count = -1, float = true })
end, { desc = "Diagnostic" })
keymap("n", "]x", function()
	vim.diagnostic.jump({ count = 1, float = true })
end, { desc = "Diagnostic" })
keymap("n", "[X", function()
	vim.diagnostic.jump({ count = -999, float = true })
end, { desc = "First diagnostic" })
keymap("n", "]X", function()
	vim.diagnostic.jump({ count = 999, float = true })
end, { desc = "Last diagnostic" })
keymap("n", "<leader>xx", function()
	vim.diagnostic.open_float({ scope = "cursor" })
end, { desc = "Cursor diagnostics" })
keymap("n", "<leader>xX", function()
	vim.diagnostic.open_float({ scope = "line" })
end, { desc = "Line diagnostics" })
keymap("n", "<leader>tv", require("utils.diagnostics").toggle_virtual_lines, { desc = "Diagnostic virtual lines" })
keymap("n", "<leader>xs", function()
	require("fzf-lua").diagnostics_document()
end, { desc = "Search document diagnostics" })
keymap("n", "<leader>xS", function()
	require("fzf-lua").diagnostics_workspace()
end, { desc = "Search workspace diagnostics" })
keymap("n", "<leader>tx", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", { desc = "Buffer diagnostics" })
keymap("n", "<leader>tX", "<cmd>Trouble diagnostics toggle<cr>", { desc = "Workspace diagnostics" })

--== Extras
keymap("n", "<leader>+q", ":cdo ", {
	desc = "[:cdo ] Do something for each quickfix item, like 's/' (use '/gc' flags as 'c' asks you every item if it is to apply)",
})
keymap("n", "<leader>+:", "q: ", {
	desc = "[q:] Open cmd window where you can see the history and use modes (insert, visual, ...). Open window in regular cmd with <C-f>.",
})
keymap("n", "<leader>+w", "<cmd>W<CR>", {
	desc = "[:W] Custom command to save without formatting.",
})
