return {
	{
		"rmagatti/auto-session",
		lazy = false,
		dependencies = {
			"nvim-telescope/telescope.nvim",
		},
		keys = {
			-- Will use Telescope if installed or a vim.ui.select picker otherwise
			{ "<leader>ps", "<cmd>SessionSearch<CR>", desc = "Session search" },
			{ "<leader>pw", "<cmd>SessionSave<CR>", desc = "Session [w]rite/save" },
			{ "<leader>pd", "<cmd>SessionDelete<CR>", desc = "Session [d]elete" },
			{ "<leader>ts", "<cmd>SessionToggleAutoSave<CR>", desc = "Toggle [s]ession autosave" },
		},

		---@module "auto-session"
		---@type AutoSession.Config
		opts = {
			suppressed_dirs = { "~/", "~/Projects", "~/Downloads", "/" },
		},
	},
}
