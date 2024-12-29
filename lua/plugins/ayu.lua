return {
	{
		"Shatur/neovim-ayu",
		name = "ayu",
		-- Make sure to load this before all the other start plugins.
		priority = 1000,
		config = function()
			require("ayu").setup({})
		end,
		init = function()
			-- Load the colorscheme.
			vim.cmd.colorscheme("ayu")
		end,
	},
}
