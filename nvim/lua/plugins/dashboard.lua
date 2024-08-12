-- Add a startup screen
-- If you delete the project list wrongly it may crash on startup, to fix do `rm -rf ~/.cache/nvim/dashboard/`
return {
	{
		"nvimdev/dashboard-nvim",
		event = "VimEnter",
		dependencies = { {
			"nvim-tree/nvim-web-devicons",
			"nvim-telescope/telescope.nvim",
		} },
		config = function()
			require("dashboard").setup({
				-- config
				theme = "hyper",
				disable_move = false,
				shortcut_type = "number",
				-- Change the directory to the root of the Version Control System
				-- instead of the parent directory
				change_to_vcs_root = true,
				config = {
					-- week_header = { enable = true },
					header = {
						[[                               __                ]],
						[[  ___     ___    ___   __  __ /\_\    ___ ___    ]],
						[[ / _ `\  / __`\ / __`\/\ \/\ \\/\ \  / __` __`\  ]],
						[[/\ \/\ \/\  __//\ \_\ \ \ \_/ |\ \ \/\ \/\ \/\ \ ]],
						[[\ \_\ \_\ \____\ \____/\ \___/  \ \_\ \_\ \_\ \_\]],
						[[ \/_/\/_/\/____/\/___/  \/__/    \/_/\/_/\/_/\/_/]],
						[[                                                 ]],
					},
					footer = {},
					packages = { enable = false },
					shortcut = {
						{
							icon = "󰝒 ",
							desc = "New File",
							action = "ene",
							key = "n",
						},
						{
							icon = "󰱼 ",
							desc = "Files",
							action = "Telescope find_files",
							key = "f",
						},
						{
							icon = "󰍉 ",
							desc = "Grep Search",
							action = "Telescope live_grep",
							key = "s",
						},
						{
							icon = "󰒲 ",
							desc = "Lazy",
							action = "Lazy",
							key = "p",
						},
						{
							icon = "󰒓 ",
							desc = "Config",
							action = function()
								require("telescope.builtin").find_files({ cwd = vim.fn.stdpath("config") })
							end,
							key = "c",
						},
					},
				},
			})
		end,
	},
}
