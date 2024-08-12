-- [[ Basic Keymaps ]]
--  See `:help vim.keymap.set()`

-- Set highlight on search, but clear on pressing <Esc> in normal mode
vim.opt.hlsearch = true
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- Diagnostic keymaps
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Go to previous [D]iagnostic message" })
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Go to next [D]iagnostic message" })
vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, { desc = "Show diagnostic [E]rror messages" })
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" })

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--
--  See `:help wincmd` for a list of all window commands
vim.keymap.set("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
vim.keymap.set("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
vim.keymap.set("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
vim.keymap.set("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })

-- Keybinds to yank and paste to the system clipboard
-- https://www.reddit.com/r/neovim/comments/17tfgmo/yank_to_clipboard_with_motions/
--
-- a collection of mappings to allow you to yank to clipboard using <leader>y
-- as well as a few nice paste options, and ctrl+a
-- in normal mode, it accepts motions as well, but I didn't know how to put that in which-key
vim.cmd([[
  " Used so that motions work when yanking on the next vim.keymap.set
  function! Yank_to_clipboard(type)
    silent exec 'normal! `[v`]"+y'
    silent exec 'let @/=@"'
  endfunction
]])
vim.keymap.set(
	"n",
	"<leader>y",
	[[:set opfunc=Yank_to_clipboard<CR>g@]],
	{ desc = "Yank to clipboard (accepts motions)" }
)
vim.keymap.set({ "v", "x" }, "<leader>y", '"+y', { desc = "Yank to clipboard" })
vim.keymap.set({ "n", "v", "x" }, "<leader>yy", '"+yy', { desc = "Yank line to clipboard" })
vim.keymap.set({ "n", "v", "x" }, "<leader>Y", '"+Y', { desc = "Yank to the end of the line to clipboard" })
vim.keymap.set({ "n", "v", "x" }, "<C-a>", "gg0vG$", { desc = "Select all" })
vim.keymap.set("n", "<leader>p", '"+p', { desc = "Paste from clipboard" })
vim.keymap.set("i", "<C-p>", "<C-r>+", { desc = "Paste from clipboard from within insert mode" })
vim.keymap.set("x", "<leader>P", '"_dP', { desc = "Paste over selection without erasing unnamed register" })

-- [[ Basic Autocommands ]]
--  See `:help lua-guide-autocommands`

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	group = vim.api.nvim_create_augroup("highlight-yank", { clear = true }),
	callback = function()
		vim.highlight.on_yank()
	end,
})
