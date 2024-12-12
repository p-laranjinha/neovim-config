-- Line numbers.
vim.opt.number = true
-- Relative line numbers.
vim.opt.relativenumber = true

-- Enable mouse for [a]ll modes.
vim.opt.mouse = "a"

-- If the mode is shown in the line where I write commands and search.
vim.opt.showmode = false

-- Sync clipboard between OS and Neovim.
-- On Wayland I may want to install `wl-clipboard` to have a working
--  clipboard provider.
--vim.opt.clipboard = "unnamedplus"

-- Every wrapped line will continue visually indented.
vim.opt.breakindent = true

-- Save undo history after file closes.
vim.opt.undofile = true

-- Case-insensitive searching UNLESS \C or one or more capital letters in the
--  search term.
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Add a column to the left of line numbers for symbols (for stuff like
--  `gitsigns`).
vim.opt.signcolumn = "yes"

-- How long it waits to write the swap file to disk.
vim.opt.updatetime = 250

-- How long it waits for a mapped sequence to complete.
-- Also affects `which-key`.
vim.opt.timeoutlen = 300

-- How new splits should be opened.
vim.opt.splitright = true
vim.opt.splitbelow = true

-- How it will display certain whitespace characters in the editor.
vim.opt.list = true
vim.opt.listchars = {
	trail = "·",
	-- `tab` has "^I" as a default.
	tab = "  ",
}

-- Preview substitutions as I type.
vim.opt.inccommand = "split"

-- Show which line my cursor is on.
vim.opt.cursorline = true

-- Minimal number of screen lines to keep above and below the cursor.
vim.opt.scrolloff = 10

-- How many spaces an indentation uses.
vim.opt.shiftwidth = 4
-- How many spaces a <Tab> is represented by.
vim.opt.tabstop = 4

-- Make a column a different color to show when the file has lines that are too
--  long.
vim.opt.colorcolumn = "80"

-- Stop the Neovim intro screen from being shown.
vim.opt.shortmess:append("I")
