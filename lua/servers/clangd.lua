-- clangd (C/C++ Language Server) LSP Setup

--- @param capabilities table LSP client capabilities (typically from nvim-cmp or similar)
--- @return nil
return function(capabilities)
	vim.lsp.config("clangd", {
		capabilities = capabilities,
		filetypes = { "c", "cpp" },
	})
end
