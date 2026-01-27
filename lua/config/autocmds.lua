-- Automatically run code on defined events.

-- Restore last cursor position when reopening a file
local last_cursor_group = vim.api.nvim_create_augroup("LastCursorGroup", {})
vim.api.nvim_create_autocmd("BufReadPost", {
	group = last_cursor_group,
	callback = function()
		local mark = vim.api.nvim_buf_get_mark(0, '"')
		local lcount = vim.api.nvim_buf_line_count(0)
		if mark[1] > 0 and mark[1] <= lcount then
			pcall(vim.api.nvim_win_set_cursor, 0, mark)
		end
	end,
})

-- Highlight the yanked text for 200ms
local highlight_yank_group = vim.api.nvim_create_augroup("HighlightYank", {})
vim.api.nvim_create_autocmd("TextYankPost", {
	group = highlight_yank_group,
	pattern = "*",
	callback = function()
		vim.hl.on_yank({
			higroup = "IncSearch",
			timeout = 200,
		})
	end,
})

-- https://github.com/folke/trouble.nvim/blob/main/docs/examples.md
-- Open Trouble Quickfix when the qf list opens. Makes the regular quickfix list unusable.
-- Look at the docs for a less extreme version.
vim.api.nvim_create_autocmd("BufRead", {
	callback = function(ev)
		if vim.bo[ev.buf].buftype == "quickfix" then
			vim.schedule(function()
				vim.cmd([[cclose]])
				vim.cmd([[Trouble qflist open]])
			end)
		end
	end,
})

-- https://github.com/nvim-tree/nvim-tree.lua/issues/1368#issuecomment-1512248492
-- https://github.com/tzhouhc/vim/blob/b9c6a5441ddac8d964ad24df2b996feb1e39d539/lua/plugins/ui/trouble.lua#L21-L32
-- exit if nvim-tree, trouble, etc. are the only buffers open
local ft_buft = require("utils.ft_buft")
vim.api.nvim_create_autocmd("QuitPre", {
	group = vim.api.nvim_create_augroup("EnsureInvalidCloses", {}),
	callback = function()
		local invalid_win = {}
		local wins = vim.api.nvim_list_wins()
		for _, w in ipairs(wins) do
			local buf = vim.api.nvim_win_get_buf(w)
			if not (ft_buft.is_normal_buffer(buf) and ft_buft.is_file_backed(buf)) then
				table.insert(invalid_win, w)
			end
		end
		if #invalid_win == #wins - 1 then
			-- Should quit, so we close all invalid windows.
			for _, w in ipairs(invalid_win) do
				vim.api.nvim_win_close(w, true)
			end
		end
	end,
})

-- Show notification explaining keymaps when a snipped autocompletion is selected.
vim.api.nvim_create_autocmd("User", {
	pattern = "LuasnipPreExpand",
	callback = function()
		local MiniNotify = require("mini.notify")
		local id = MiniNotify.add("Use <C-l> and <C-h> to navigate snippet fields.", "INFO")
		vim.defer_fn(function()
			MiniNotify.remove(id)
		end, 5000)
	end,
})

-- format on save using efm langserver and configured formatters
local lsp_fmt_group = vim.api.nvim_create_augroup("FormatOnSaveGroup", {})
vim.api.nvim_create_autocmd("BufWritePre", {
	group = lsp_fmt_group,
	callback = function()
		local efm = vim.lsp.get_clients({ name = "efm" })
		if vim.tbl_isempty(efm) then
			return
		end
		if vim.g.autoformat then
			-- async=true causes the file to not be saved after the format
			vim.lsp.buf.format({ name = "efm", async = false })
		end
	end,
})
