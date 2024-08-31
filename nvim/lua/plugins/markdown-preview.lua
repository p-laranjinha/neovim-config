-- Open a preview for Markdown files in the browser.
return {
	{
		"iamcco/markdown-preview.nvim",
		cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
		ft = { "markdown" },
		build = function()
			vim.fn["mkdp#util#install"]()
		end,
		init = function()
			vim.keymap.set("n", "<leader>tm", "<plug>MarkdownPreviewToggle", { desc = "Toggle [m]arkdown preview" })
		end,
	},
}
