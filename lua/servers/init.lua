local capabilities = require("cmp_nvim_lsp").default_capabilities()

-- Automatically install LSPs, DAPs, Linters and Formatters.
-- Check the requires below to see what's wanted.
-- You could also just install these with the system's package manager.
require("mason-tool-installer").setup({
	ensure_installed = {
		"efm", -- language server that applies the linters and formatters
		"lua_ls", -- lua language server
		"luacheck", -- lua linter
		"stylua", -- lua formatter
		"nil_ls", -- nix language server
		-- "statix", -- nix linter
		-- "nixfmt", -- nix formatter
		"bashls", -- bash language server
		"shellcheck", -- bash linter
		"shfmt", -- bash formatter
		"pyright", -- python language server
		"flake8", -- python linter
		"black", -- python formatter
		"dockerls", -- docker language server
		"hadolint", -- docker linter

		"ts_ls", -- ts/js language server
		"eslint_d", -- ts/js/json/etc. linter
		"prettierd", -- ts/js/json/etc. formatter
		"emmet_ls", -- html/js/etc language server for dynamic snippets

		"jsonls", -- json language server
		"yamlls", -- yaml language server, linter, formatter
		"tombi", -- toml language server, linter, formatter
	},
})

-- Language Server Protocol (LSP)
require("servers.lua_ls")(capabilities)
require("servers.bashls")(capabilities)
require("servers.pyright")(capabilities)
require("servers.dockerls")(capabilities)

require("servers.ts_ls")(capabilities)
require("servers.emmet_ls")(capabilities)

require("servers.jsonls")(capabilities)
require("servers.yamlls")(capabilities)
require("servers.tombi")(capabilities)

-- Linters & Formatters
require("servers.efm-langserver")(capabilities)
