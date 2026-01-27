return {
	{
		"EdenEast/nightfox.nvim",
		lazy = false, -- Don't lazy load.
		priority = 999, -- One of the first to be loaded.
		config = function()
			-- TODO: Look into making nvim and the terminal transparent.
			local palette = require("nightfox.palette").load("carbonfox")
			require("nightfox").setup({
				-- options = {
				--     transparent = true,
				-- },
				-- groups = {
				--     carbonfox = {
				--         Visual = { bg = palette.bg1 },
				--     },
				-- },
			})
			vim.cmd("colorscheme carbonfox")
		end,
	},
	{
		"xiyaowong/nvim-transparent",
		lazy = false,
		priority = 999,
	},
	-- Other cool themes:
	"rebelot/kanagawa.nvim",
	"folke/tokyonight.nvim",
	"tiagovla/tokyodark.nvim",
	"Shatur/neovim-ayu",
	"Mofiqul/vscode.nvim",
	{ "catppuccin/nvim", name = "catppuccin" },
	{ "rose-pine/neovim", name = "rose-pine" },
}
