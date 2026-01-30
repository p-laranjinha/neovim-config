-- Quickstart configurations for the built-in Neovim LSP client.
return {
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			{ "mason-org/mason.nvim", opts = {} }, -- LSP/DAP/Linter installer & manager
			-- Adds the :LspInstall command and the ability to automatically enable and install LSPs.
			-- Also makes it so that 'mason-tool-installer' can use lspconfig package names.
			{ "mason-org/mason-lspconfig.nvim", opts = {} },
			-- Adds the ability to automatically install LSPs, linters, etc.
			"WhoIsSethDaniel/mason-tool-installer.nvim",
			"creativenull/efmls-configs-nvim", -- Preconfigured EFM Language Server setups
			"hrsh7th/cmp-nvim-lsp", -- nvim-cmp source for LSP-based completion
		},
		config = function()
			-- on attach function shortcuts
			local on_attach = require("utils.lsp").on_attach
			local lsp_on_attach_group = vim.api.nvim_create_augroup("LspMappings", {})
			vim.api.nvim_create_autocmd("LspAttach", {
				group = lsp_on_attach_group,
				callback = on_attach,
			})
			require("utils.diagnostics").setup()
			require("servers")
		end,
	},
}
