return {
	"rmagatti/auto-session",
	lazy = false,
	keys = {
		-- Will use Telescope if installed or a vim.ui.select picker otherwise
		{ "<leader>\\s", "<cmd>SessionSearch<CR>", desc = "Session search" },
		{ "<leader>\\w", "<cmd>SessionSave<CR>", desc = "Session write/save" },
		{ "<leader>\\d", "<cmd>SessionDelete<CR>", desc = "Session delete" },
		{ "<leader>\\a", "<cmd>SessionToggleAutoSave<CR>", desc = "Toggle session autosave" },
	},

	---@module "auto-session"
	---@type AutoSession.Config
	opts = {
		suppressed_dirs = { "~/", "~/Projects", "~/Downloads", "/" },
	},
}
