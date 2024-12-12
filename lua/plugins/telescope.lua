-- Fuzzy finder for basically everything.
return {
	{
		"nvim-telescope/telescope.nvim",
		event = "VimEnter",
		branch = "0.1.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			{
				"nvim-telescope/telescope-fzf-native.nvim",
				build = "make",
				-- `cond` is a condition used to determine whether this plugin
				--  should be installed and loaded.
				cond = function()
					return vim.fn.executable("make") == 1
				end,
			},
			{ "nvim-telescope/telescope-ui-select.nvim" },

			-- Useful for getting pretty icons, but requires a Nerd Font.
			{ "nvim-tree/nvim-web-devicons", enabled = vim.g.have_nerd_font },
		},
		config = function()
			require("telescope").setup({
				defaults = {
					mappings = {
						-- Finishes search and starts a new search with the
						--  results of the previous one.
						i = { ["<c-enter>"] = "to_fuzzy_refine" },
					},
				},
				extensions = {
					["ui-select"] = {
						require("telescope.themes").get_dropdown(),
					},
				},
			})

			-- Enable Telescope extensions if they are installed.
			pcall(require("telescope").load_extension, "fzf")
			pcall(require("telescope").load_extension, "ui-select")

			local builtin = require("telescope.builtin")
			vim.keymap.set("n", "<leader>sh", builtin.help_tags, { desc = "Search [h]elp" })
			vim.keymap.set("n", "<leader>sk", builtin.keymaps, { desc = "Search [k]eymaps" })
			vim.keymap.set("n", "<leader>sf", builtin.find_files, { desc = "Search [f]iles" })
			vim.keymap.set("n", "<leader>si", function()
				builtin.find_files({ no_ignore = true })
			end, { desc = "Search files (including [i]gnored)" })
			vim.keymap.set("n", "<leader>ss", builtin.builtin, { desc = "Search [s]elect telescope" })
			vim.keymap.set("n", "<leader>sw", builtin.grep_string, { desc = "Search current [w]ord" })
			vim.keymap.set("n", "<leader>sg", builtin.live_grep, { desc = "Search by [g]rep" })
			vim.keymap.set("n", "<leader>sd", builtin.diagnostics, { desc = "Search [d]iagnostics" })
			vim.keymap.set("n", "<leader>sr", builtin.resume, { desc = "Search [r]esume" })
			vim.keymap.set("n", "<leader>s.", builtin.oldfiles, { desc = "Search recent files ([.] for repeat)" })
			vim.keymap.set("n", "<leader><leader>", builtin.buffers, { desc = "Find existing buffers" })

			vim.keymap.set("n", "<leader>st", ":TodoTelescope<cr>", { desc = "Search project [t]odos" })
			vim.keymap.set("n", "<leader>sc", builtin.colorscheme, { desc = "Search [c]olor schemes" })

			vim.keymap.set("n", "<leader>/", function()
				builtin.current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
					winblend = 10,
					previewer = false,
					layout_config = {
						width = 0.95,
						height = 0.95,
					},
				}))
			end, { desc = "Fuzzily search in current buffer" })

			vim.keymap.set("n", "<leader>s/", function()
				builtin.live_grep({
					grep_open_files = true,
					prompt_title = "Live Grep in Open Files",
				})
			end, { desc = "Search in open files" })

			vim.keymap.set("n", "<leader>sn", function()
				builtin.find_files({ cwd = vim.fn.stdpath("config") })
			end, { desc = "Search [n]eovim files" })
		end,
	},
}
