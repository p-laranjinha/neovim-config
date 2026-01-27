-- This file is mostly for keymaps that don't use plugins, the ones that do should go in the
--  corresponding plugin folder.

-- INFO: To define which-key keymap groups and icons go to: ../plugins/which-key.lua
-- INFO: To change descriptions for existing keymaps go to: ../plugins/which-key.lua
-- INFO: For LSP buffer-local keymaps go to: ../utils/lsp.lua
--  Technically diagnostics doesn't depends on LSP, but I only use it with it so I'll put those here.
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
	require("trouble").open({ mode = "todo", filter = { tag = to_fix_keywords } })
end, { desc = "To do and fix" })
keymap("n", "<leader>tta", "<cmd>TodoTrouble<CR>", { desc = "All" })

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

--== Extras
keymap("n", "<leader>+q", ":cdo ", {
	desc = "[:cdo ] Do something for each quickfix item, like 's/' (use '/gc' flags as 'c' asks you every item if it is to apply)",
})
keymap("n", "<leader>+:", "q: ", {
	desc = "[q:] Open cmd window where you can see the history and use modes (insert, visual, ...). Open window in regular cmd with <C-f>.",
})
