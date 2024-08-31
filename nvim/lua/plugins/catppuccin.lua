return {
	{
		"catppuccin/nvim",
		-- Lazy thinks this plugins name is "nvim" by default, so I change it.
		name = "catppuccin",
		-- Make sure to load this before all the other start plugins.
		priority = 1000,
		config = function()
			require("catppuccin").setup({
				styles = {
					-- Make comments not italic.
					comments = {},
				},
			})
		end,
		init = function()
			-- Load the colorscheme.
			vim.cmd.colorscheme("catppuccin-mocha")
		end,
	},
}
