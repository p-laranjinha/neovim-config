-- Fast and easy to configu statusline.
return {
	"nvim-lualine/lualine.nvim",
	config = function()
		require("lualine").setup({
			options = {
				theme = "carbonfox",
				icons_enabled = true,
			},
		})
	end,
	dependencies = { "nvim-tree/nvim-web-devicons" },
}
