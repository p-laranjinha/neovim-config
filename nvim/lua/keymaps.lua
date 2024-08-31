-- Set highlight on search, but clear on pressing <Esc> in normal mode.
vim.opt.hlsearch = true
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- Diagnostic keymaps.
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Go to previous [d]iagnostic message" })
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Go to next [d]iagnostic message" })
vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, { desc = "Show diagnostic [e]rror messages" })
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic [q]uickfix list" })

-- Exit terminal mode in the builtin terminal.
-- This won't work in all terminal emulators/tmux/etc. Try another mapping or
--  just use <C-\><C-n> to exit terminal mode.
vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

-- Easier split navigation.
-- See `:help wincmd` for a list of all window commands.
vim.keymap.set("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
vim.keymap.set("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
vim.keymap.set("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
vim.keymap.set("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })

-- Yank to and paste from the system clipboard.
vim.keymap.set({ "n", "v", "x" }, "<leader>y", '"+y', { desc = "[y]ank to clipboard with motions" })
vim.keymap.set({ "n", "v", "x" }, "<leader>Y", '"+Y', { desc = "[Y]ank to clipboard until the end of the line" })
vim.keymap.set("n", "<leader>p", '"+p', { desc = "[p]aste from clipboard" })

vim.keymap.set("n", "<leader>n", vim.cmd.ene, { desc = "[n]ew unnamed buffer" })

-- Highlight when yanking text.
vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	group = vim.api.nvim_create_augroup("highlight-yank", { clear = true }),
	callback = function()
		vim.highlight.on_yank()
	end,
})
