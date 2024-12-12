-- Add a padding buffer to center the regular buffers.
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
			vim.keymap.set("n", "<leader>tn", vim.cmd.NoNeckPain, { desc = "Toggle [n]oNeckPain" })
		end,
	},
}
