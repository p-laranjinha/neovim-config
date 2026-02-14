-- Makes it so that yanking doesn't move my cursor to the start of the yank.
-- More popular but harder to configure alternative: https://github.com/gbprod/yanky.nvim
return {
	"svban/YankAssassin.nvim",
	event = "VeryLazy",
	config = function()
		require("YankAssassin").setup({
			auto_normal = true,
			auto_visual = true,
		})
	end,
}
