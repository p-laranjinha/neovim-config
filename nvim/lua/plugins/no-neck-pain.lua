-- use :NoNeckPain to center the buffer (with left and right borders)
return {
	{
		"shortcuts/no-neck-pain.nvim",
		version = "*",
		config = function()
			local NoNeckPain = require("no-neck-pain")
			NoNeckPain.setup({
				width = 100,
				buffers = {
					right = {
						enabled = false,
					},
				},
			})
			-- NoNeckPain.enable()
			vim.keymap.set("n", "<leader>np", "<cmd>NoNeckPain<cr>", { desc = "Toggle No[N]eck[P]ain" })
		end,
	},
}
