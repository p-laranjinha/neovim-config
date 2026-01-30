-- Fast and easy to configu statusline.
return {
	"nvim-lualine/lualine.nvim",
	config = function()
		local trouble = require("trouble")
		local symbols = trouble.statusline({
			mode = "lsp_document_symbols",
			groups = {},
			title = false,
			filter = { range = true },
			format = "{kind_icon}{symbol.name:Normal}",
			-- The following line is needed to fix the background color
			-- Set it to the lualine section you want to use
			hl_group = "lualine_c_normal",
		})
		-- See the default config here:
		-- https://github.com/nvim-lualine/lualine.nvim?tab=readme-ov-file#default-configuration
		require("lualine").setup({
			options = {
				icons_enabled = true,
			},
			extensions = {
				"trouble",
				"nvim-tree",
				"nvim-dap-ui",
			},
			sections = {
				lualine_b = {
					"branch",
					{
						"diff",
						symbols = {
							added = " ",
							modified = " ",
							removed = " ",
						},
					},
					{
						"diagnostics",
						symbols = {
							error = " ",
							warn = " ",
							info = " ",
							hint = " ",
						},
					},
				},
				-- Putting "filename" on the right so it's always visible even with too many symbols.
				lualine_c = {
					{
						"filename",
						cond = function()
							return not (symbols.has() and (vim.b.has_lsp == true))
						end,
					},
					{
						symbols.get,
						cond = function()
							return symbols.has() and (vim.b.has_lsp == true)
						end,
					},
				},
				lualine_x = {
					{
						"filename",
						cond = function()
							return symbols.has() and (vim.b.has_lsp == true)
						end,
					},
				},
				lualine_y = { "encoding", "fileformat", "filetype" },
				lualine_z = { "progress", "location" },
			},
		})
	end,
	dependencies = { "echasnovski/mini.icons" },
}
