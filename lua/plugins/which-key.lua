-- Display keybindings as you type.
return {
	"folke/which-key.nvim",
	event = "VeryLazy",
	opts = {},
	config = function()
		local which_key = require("which-key")
		which_key.add({
			-- Group names and icons.
			{ "<leader>?", group = "Keymaps (which-key)", icon = "󰥻" },
			{ "<leader>w", group = "Window" },
			{ "<leader>t", group = "Toggle" },
			{ "<leader>tt", group = "Todo", icon = "󰷐" },
			{ "<leader>s", group = "Search" },
			{ "<leader>st", group = "Todo", icon = "󰷐" },
			{ "<leader>x", group = "Diagnostics" },
			-- TODO: figure out tests https://github.com/nvim-neotest/neotest
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

			-- TODO: maybe colors
			-- TODO: add extras for going back/forwards in jumps

			-- Icons.
			{ "<leader>?l", icon = "󰈔" },
			{ "<leader>?g", icon = "" },
			{ "<leader>y", icon = "󰆏" },
			{ "<leader>Y", icon = "󰆏" },
			{ "<leader>p", icon = "󰆒" },
			{ "<leader>P", icon = "󰆒" },
			{ "<leader>u", icon = "" },
			{ "<leader>r", icon = "󰑕" },
			{ "<leader>f", icon = "󰈮" },
			{ "<leader>e", icon = "" },

			-- Toggle icons.
			{ "<leader>tu", icon = "" },
			{ "<leader>tm", icon = "󰍔" },
			{ "<leader>tw", icon = "󰖶" },
			{ "<leader>ts", icon = "" },
			{ "<leader>tx", icon = { icon = "󱖫", color = "green" } },
			{ "<leader>th", icon = "󰫧" },
			{ "<leader>tl", icon = "🅻" },
			{ "<leader>ttt", icon = "" },
			{ "<leader>tta", icon = "" },

			-- LSP icons.
			{ "<leader>lf", icon = "🅻" },
			{ "<leader>ls", icon = "" },
			{ "<leader>lS", icon = "" },
			{ "<leader>lr", icon = "" },
			{ "<leader>lR", icon = "󰑕" },
			{ "<leader>lt", icon = "" },
			{ "<leader>li", icon = "" },
			{ "<leader>ld", icon = "" },
			{ "<leader>lD", icon = "󱍟" },
			{ "<leader>la", icon = "" },
			{ "<leader>lo", icon = "󰋺" },

			-- DAP icons.
			{ "<leader>di", icon = "" },
			{ "]d", icon = "" },
			{ "<leader>do", icon = "" },
			{ "]D", icon = "" },
			{ "<leader>dO", icon = "" },
			{ "[d", icon = "" },
			{ "<leader>dI", icon = "" },
			{ "[D", icon = "" },
			{ "<leader>dc", icon = "" },
			{ "<leader>dC", icon = "" },
			{ "<leader>dl", icon = "" },
			{ "<leader>dp", icon = "" },
			{ "<leader>ds", icon = "" },
			{ "<leader>de", icon = "" },
			{ "<leader>dg", icon = "" },
			{ "<leader>db", icon = "" },
			{ "<leader>dB", icon = "" },
			{ "<leader>da", icon = "" },
			{ "<leader>dj", icon = "󰄠" },
			{ "<leader>dk", icon = "󰄝" },
			{ "<leader>dw", icon = "" },
			{ "<leader>dr", icon = "" },
			{ "<leader>du", icon = "󰙵" },

			-- Git
			{ "<leader>gb", icon = "" },
			{ "<leader>gd", icon = "" },
			{ "<leader>gD", icon = "" },
			{ "<leader>gn", icon = "󰁅" },
			{ "<leader>gN", icon = "󰞒" },
			{ "<leader>gp", icon = "󰁝" },
			{ "<leader>gP", icon = "󰞕" },
			{ "<leader>gr", icon = "󰩹" },
			{ "<leader>gR", icon = "󰩹" },
			{ "<leader>gs", icon = "" },
			{ "<leader>gS", icon = "" },
			{ "<leader>gu", icon = "" },
			{ "<leader>gtb", icon = "" },
			{ "<leader>gts", icon = "" },
			{ "<leader>gtl", icon = "󰸱" },
			{ "<leader>gtw", icon = "" },
			{ "<leader>gtd", icon = "󰩹" },

			-- Search
			{ "<leader>stt", icon = "" },
			{ "<leader>sta", icon = "" },
			{ "<leader>sh", icon = "󰞋" },
			{ "<leader>sc", icon = "" },
			{ "<leader>sC", icon = "" },
			{ "<leader>sg", icon = "󰈞" },
			{ "<leader>s/", icon = "󰈞" },
			{ "<leader>sw", icon = "󰈞" },
			{ "<leader>sk", icon = "󰥻" },
			{ "<leader>sn", icon = "" },
			{ "<leader>sr", icon = "" },
			{ "<leader>si", icon = "󰘓" },
			{ "<leader>so", icon = "" },
			{ "<leader>sb", icon = "" },

			-- Window
			{ "<leader>ws", icon = "" },
			{ "<leader>wv", icon = "" },
			{ "<leader>wh", icon = "󱂪" },
			{ "<leader>wj", icon = "󱂩" },
			{ "<leader>wk", icon = "󱔓" },
			{ "<leader>wl", icon = "󱂫" },
			{ "<leader>w\\", icon = "󰮳" },
			{ "<leader>wH", icon = "" },
			{ "<leader>wJ", icon = "" },
			{ "<leader>wK", icon = "" },
			{ "<leader>wL", icon = "" },
			{ "<leader>w<A-h>", icon = "󰧙" },
			{ "<leader>w<A-j>", icon = "󰧗" },
			{ "<leader>w<A-k>", icon = "󰧝" },
			{ "<leader>w<A-l>", icon = "󰧛" },
			{ "<leader>w|", icon = "󰡎" },
			{ "<leader>w_", icon = "󰡏" },
			{ "<leader>w=", icon = "" },
			{ "<leader>wq", icon = "󰅗" },
			{ "<leader>wo", icon = "󰱝" },
			{ "<leader>w<space>", icon = "󰑖" },
			{ "<leader>ww", icon = "" },
			{ "<C-w><space>", icon = "󰑖" },

			-- mini.indentscope new descriptions and icons
			{ "ii", mode = "ox", desc = "Indent (Object scope)", icon = "󰉶" },
			{ "ai", mode = "ox", desc = "Around indent (Object scope)", icon = "󰉶" },
			{ "[i", desc = "Indent top (Object scope)", icon = "󰉶" },
			{ "]i", desc = "Indent bottom (Object scope)", icon = "󰉶" },
		})
	end,
}
