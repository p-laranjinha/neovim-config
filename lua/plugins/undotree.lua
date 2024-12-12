-- Better undo that saves the previous file versions in a tree.
return {
	{
		"mbbill/undotree",
		config = function()
			vim.keymap.set("n", "<leader>u", function()
				vim.cmd.UndotreeToggle()
				vim.cmd.UndotreeFocus()
			end, { desc = "[u]ndotree" })
		end,
	},
}
