-- Display keybindings as you type.
return {
	"folke/which-key.nvim",
	event = "VeryLazy",
	opts = {},
	config = function()
		require("which-key").add({
			{
				"<leader>?",
				function()
					require("which-key").show({ global = false })
				end,
				desc = "Buffer Local Keymaps (which-key)",
			},
			{
				-- Make window keymaps keep <C-w> context
				"<leader>w",
				function()
					require("which-key").show({ keys = "<C-w>", loop = true })
				end,
				group = "Window",
			},
			{ "<leader>t", group = "Toggle" },
			{ "<leader>f", group = "Find" },
			{ "<leader>x", group = "Trouble" },
			{ "<leader>y", icon = "󰆏" },
			{ "<leader>Y", icon = "󰆏" },
			{ "<leader>p", icon = "󰆒" },
			{ "<leader>P", icon = "󰆒" },
			{ "<leader>;", icon = "󰁋" },
		})
	end,
}
