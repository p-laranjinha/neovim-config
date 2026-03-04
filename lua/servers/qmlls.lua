-- qmlls LSP Setup

--- @param capabilities table LSP client capabilities (typically from nvim-cmp or similar)
--- @return nil
return function(capabilities)
	vim.lsp.enable("qmlls")
	vim.lsp.config("qmlls", {
		cmd = { "qmlls" },
		capabilities = capabilities,
		filetypes = { "qml" },
	})
end
