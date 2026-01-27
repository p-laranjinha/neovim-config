-- Display keybindings as you type.
return {
	"folke/which-key.nvim",
	event = "VeryLazy",
	opts = {},
	config = function()
		require("which-key").add({
			-- Setting group names and icons.
			{ "<leader>?", group = "Keymaps (which-key)", icon = "󰥻" },
			{ "<leader>t", group = "Toggle" },
			{ "<leader>tt", group = "Todo" },
			{ "<leader>s", group = "Search" },
			{ "<leader>st", group = "Todo" },
			{ "<leader>x", group = "Diagnostics" },
			{ "<leader>T", group = "Test" },
			{ "<leader>d", group = "Debug" },
			{ "<leader>l", group = "LSP", icon = "🅻" },
			{ "<leader>g", group = "Git" },
			{ "<leader>gt", group = "Toggle" },
			-- Remapped useful keymaps that wouldn't show up in which-key so that I can remember them and
			--  learn to use the actual keymaps. Like 'K' for LSP hover documentation.
			-- Technically <leader>? already does this for buffer specific keymaps, and I could add a
			--  version for all keymaps,
			{ "<leader>+", group = "Extras", icon = "" },
			-- TODO: Replace these sessions with TMUX sessions
			{ "<leader>\\", group = "Session" },

			-- Adding icons.
			{ "<leader>?l", icon = "󰈔" },
			{ "<leader>?g", icon = "" },
			{ "<leader>y", icon = "󰆏" },
			{ "<leader>Y", icon = "󰆏" },
			{ "<leader>p", icon = "󰆒" },
			{ "<leader>P", icon = "󰆒" },
			{ "<leader>u", icon = "󰕍" },
			{ "<leader>tu", icon = "󰕍" },
			{ "<leader>r", icon = "🅻" },

			-- mini.indentscope new descriptions and icons
			{ "ii", mode = "ox", desc = "Indent (Object scope)", icon = "󰉶" },
			{ "ai", mode = "ox", desc = "Around indent (Object scope)", icon = "󰉶" },
			{ "[i", desc = "Indent top (Object scope)", icon = "󰉶" },
			{ "]i", desc = "Indent bottom (Object scope)", icon = "󰉶" },
		})
	end,
}
