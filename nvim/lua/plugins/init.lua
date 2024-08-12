-- Use this file for plugins that don't need configuration
return {
	{
		"tpope/vim-sleuth", -- Detect tabstop and shiftwidth automatically
		-- "gc" to comment visual regions/lines
		-- `opts` seems to be required for more comment shortcuts to work
		{ "numToStr/Comment.nvim", opts = {} },
	},
}
