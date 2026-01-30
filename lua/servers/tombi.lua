-- tombi (TOML Language Server) LSP Setup

--- @param capabilities table LSP client capabilities (typically from nvim-cmp or similar)
--- @return nil
return function(capabilities)
	vim.lsp.config("tombi", {
		capabilities = capabilities,
		settings = {
			tombi = {
				validate = true,
				format = {
					enable = true,
				},
			},
		},
		filetypes = { "toml" },
	})
end
