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
			require("utils.diagnostics").setup()
			require("servers")
		end,
	},
}
