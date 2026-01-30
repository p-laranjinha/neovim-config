-- nil_ls (Nix Language Server) LSP Setup

--- @param capabilities table LSP client capabilities (typically from nvim-cmp or similar)
--- @return nil
return function(capabilities)
	vim.lsp.config("nil_ls", {
		capabilities = capabilities,
		filetypes = { "nix" },
	})
end
