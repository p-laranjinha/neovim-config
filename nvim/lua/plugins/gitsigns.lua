return {
	{
		"lewis6991/gitsigns.nvim",
		opts = {
			on_attach = function(bufnr)
				local gitsigns = require("gitsigns")

				local function map(mode, l, r, opts)
					opts = opts or {}
					opts.buffer = bufnr
					vim.keymap.set(mode, l, r, opts)
				end

				-- Navigation
				map("n", "]c", function()
					if vim.wo.diff then
						vim.cmd.normal({ "]c", bang = true })
					else
						gitsigns.nav_hunk("next")
					end
				end, { desc = "Jump to next Git [c]hange" })

				map("n", "[c", function()
					if vim.wo.diff then
						vim.cmd.normal({ "[c", bang = true })
					else
						gitsigns.nav_hunk("prev")
					end
				end, { desc = "Jump to previous Git [c]hange" })

				-- Actions
				map("n", "<leader>hs", gitsigns.stage_hunk, { desc = "Git [s]tage hunk" })
				map("v", "<leader>hs", function()
					gitsigns.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
				end, { desc = "Git [s]tage hunk" })
				map("n", "<leader>hr", gitsigns.reset_hunk, { desc = "Git [r]eset hunk" })
				map("v", "<leader>hr", function()
					gitsigns.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
				end, { desc = "Git [r]eset hunk" })
				map("n", "<leader>hS", gitsigns.stage_buffer, { desc = "Git [S]tage buffer" })
				map("n", "<leader>hu", gitsigns.undo_stage_hunk, { desc = "Git [u]ndo stage hunk" })
				map("n", "<leader>hR", gitsigns.reset_buffer, { desc = "Git [R]eset buffer" })
				map("n", "<leader>hp", gitsigns.preview_hunk, { desc = "Git [p]review hunk" })
				map("n", "<leader>hb", gitsigns.blame_line, { desc = "Git [b]lame line" })
				map("n", "<leader>hd", gitsigns.diffthis, { desc = "Git [d]iff against index" })
				map("n", "<leader>hD", function()
					gitsigns.diffthis("@")
				end, { desc = "Git [D]iff against last commit" })

				-- Text object
				-- Using a string instead of "gitsigns.select_hunk" because the
				--  lua method only selects from the cursor down.
				map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>")

				-- Toggles
				map("n", "<leader>tg", gitsigns.toggle_signs, { desc = "Toggle [g]it signs" })
				map("n", "<leader>tb", gitsigns.toggle_current_line_blame, { desc = "Toggle git [b]lame line" })
				map("n", "<leader>tD", gitsigns.toggle_deleted, { desc = "Toggle [D]eleted git hunks inline" })
			end,
		},
	},
}
