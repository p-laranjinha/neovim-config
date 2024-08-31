-- Shows popup with pending keybinds.
return {
	{
		"echasnovski/mini.clue",
		config = function()
			local clue = require("mini.clue")
			clue.setup({
				triggers = {
					-- Leader triggers
					{ mode = "n", keys = "<Leader>" },
					{ mode = "x", keys = "<Leader>" },

					-- Built-in completion
					{ mode = "i", keys = "<C-x>" },

					-- Marks
					{ mode = "n", keys = "'" },
					{ mode = "n", keys = "`" },
					{ mode = "x", keys = "'" },
					{ mode = "x", keys = "`" },

					-- Registers
					{ mode = "n", keys = '"' },
					{ mode = "x", keys = '"' },
					{ mode = "i", keys = "<C-r>" },
					{ mode = "c", keys = "<C-r>" },

					-- Window commands
					{ mode = "n", keys = "<C-w>" },

					{ mode = "n", keys = "g" },
					{ mode = "x", keys = "g" },

					{ mode = "n", keys = "z" },
					{ mode = "x", keys = "z" },

					{ mode = "n", keys = "s" },
					{ mode = "x", keys = "s" },
				},

				clues = {
					{ mode = "n", keys = "<leader>c", desc = "+[c]ode" },
					{ mode = "n", keys = "<leader>d", desc = "+[d]ocument" },
					{ mode = "n", keys = "<leader>r", desc = "+[r]ename" },
					{ mode = "n", keys = "<leader>s", desc = "+[s]earch" },
					{ mode = "n", keys = "<leader>w", desc = "+[w]orkspace" },
					{ mode = "n", keys = "<leader>t", desc = "+[t]oggle" },
					{ mode = "n", keys = "<leader>p", desc = "+[p]rojects" },
					{ mode = "n", keys = "<leader>h", desc = "+Git [h]unk" },
					{ mode = "v", keys = "<leader>h", desc = "+Git [h]unk" },

					clue.gen_clues.builtin_completion(),
					-- clue.gen_clues.g(),
					{ mode = "n", keys = "g'", desc = "Jump to mark (doesn't affect jumplist)" },
					{ mode = "n", keys = "g`", desc = "Jump to mark (doesn't affect jumplist)" },
					clue.gen_clues.marks(),
					clue.gen_clues.registers({ show_contents = true }),
					clue.gen_clues.windows(),
					clue.gen_clues.z(),
				},

				window = {
					delay = 0,
					config = {
						width = "auto",
					},
				},
			})
		end,
	},
}
