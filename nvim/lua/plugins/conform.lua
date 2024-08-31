-- Autoformat.
return {
	{
		"stevearc/conform.nvim",
		event = { "BufWritePre" },
		cmd = { "ConformInfo" },
		keys = {
			{
				"<leader>f",
				function()
					require("conform").format({
						async = true,
						-- Just use the LSP/Mason formatters if I haven't set
						--  one for the language below.
						lsp_format = "fallback",
					})
				end,
				mode = "",
				desc = "[f]ormat buffer",
			},
		},
		opts = {
			notify_on_error = false,
			format_on_save = function(bufnr)
				-- Disable "format_on_save lsp_fallback" for languages that
				--  don't have a well standardized coding style.
				local disable_filetypes = { c = true, cpp = true }
				local lsp_format_opt
				if disable_filetypes[vim.bo[bufnr].filetype] then
					lsp_format_opt = "never"
				else
					lsp_format_opt = "fallback"
				end
				return {
					timeout_ms = 500,
					lsp_format = lsp_format_opt,
				}
			end,
			formatters_by_ft = {
				-- Conform will run multiple formatters sequentially unless
				--  "stop_after_first" is true.
				lua = { "stylua" },
				javascript = { "prettierd", stop_after_first = true },
			},
		},
	},
}
