-- Install `lazy.nvim` plugin manager if it's not installed.
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
end ---@diagnostic disable-next-line: undefined-field
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
	-- Load all the .lua files inside the lua/plugins folder as lazy plugins.
	-- `init.lua` has priority?
	spec = {
		{ import = "plugins" },
	},
	change_detection = { notify = false },
	ui = {
		-- If I am using a Nerd Font: set icons to an empty table which will
		--  use the default lazy.nvim defined Nerd Font icons, otherwise define
		--  a unicode icons table.
		icons = vim.g.have_nerd_font and {} or {
			cmd = "⌘",
			config = "🛠",
			event = "📅",
			ft = "📂",
			init = "⚙",
			keys = "🗝",
			plugin = "🔌",
			runtime = "💻",
			require = "🌙",
			source = "📄",
			start = "🚀",
			task = "📌",
			lazy = "💤 ",
		},
	},
})
