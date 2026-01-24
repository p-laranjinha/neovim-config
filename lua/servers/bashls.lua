-- bashls (Bash Language Server) LSP Setup

--- @param capabilities table LSP client capabilities (typically from nvim-cmp or similar)
--- @return nil
return function(capabilities)
	vim.lsp.config("bashls", {
		capabilities = capabilities,
		filetypes = { "sh", "bash", "zsh" },
	})
end
