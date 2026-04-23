return {
	"OXY2DEV/markview.nvim",
	lazy = false,
	config = function()
		require("markview").setup({
			markdown = {
				-- Inspired by the glow preset.
				headings = {
					enable = true,
					shift_width = 0,
					heading_1 = {
						style = "label",
						sign = "",
						padding_left = " ",
						padding_right = " ",
					},
					heading_2 = {
						style = "label",
						sign = "",
						padding_left = "   ",
						padding_right = " ",
					},
					heading_3 = {
						style = "label",
						padding_left = "     ",
						padding_right = " ",
					},
					heading_4 = {
						style = "label",
						padding_left = "       ",
						padding_right = " ",
					},
					heading_5 = {
						style = "label",
						padding_left = "         ",
						padding_right = " ",
					},
					heading_6 = {
						style = "label",
						padding_left = "           ",
						padding_right = " ",
					},
				},
			},
			preview = {
				-- Makes it so the line under the cursor displays the raw text in normal mode.
				hybrid_modes = { "n" },
				icon_provider = "mini",
			},
		})
	end,
}
