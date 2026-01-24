-- dockerls (Docker Language Server) LSP Setup

--- @param capabilities table LSP client capabilities (typically from nvim-cmp or similar)
--- @return nil
return function(capabilities)
	vim.lsp.config("dockerls", {
		capabilities = capabilities,
		filetypes = { "dockerfile" },
	})
end
