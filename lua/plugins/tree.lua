-- A file explorer tree.

return {
	"nvim-tree/nvim-tree.lua",
	lazy = false,
	config = function()
		-- Remove background color from the NvimTree window (ui fix)
		vim.cmd([[hi NvimTreeNormal guibg=NONE ctermbg=NONE]])

		require("nvim-tree").setup({
			filters = {
				dotfiles = false, -- Show hidden files (dotfiles)
			},
			view = {
				adaptive_size = true,
			},
			renderer = {
				icons = {
					git_placement = "signcolumn",
				},
			},
			on_attach = function(bufnr)
				local api = require("nvim-tree.api")
				local function opts(desc)
					return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
				end
				-- Use default mappings.
				api.config.mappings.default_on_attach(bufnr)
				-- Make '?' open help.
				vim.keymap.set("n", "?", api.tree.toggle_help, opts("Help"))
			end,
		})
	end,
}
