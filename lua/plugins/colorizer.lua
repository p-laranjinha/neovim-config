-- Highlights colors.
return {
	"brenoprata10/nvim-highlight-colors",
	config = function()
		require("nvim-highlight-colors").setup({
			enable_tailwind = true,
			-- This plugin should only color names in the correct places, so this option isn't needed.
			-- enable_named_colors = false,
		})
	end,
}
