-- General purpose LSP that "applies" linters and formatters

--- @param capabilities table LSP client capabilities (from nvim-cmp)
--- @return nil
return function(capabilities)
	-- https://github.com/creativenull/efmls-configs-nvim/blob/main/doc/SUPPORTED_LIST.md
	local luacheck = require("efmls-configs.linters.luacheck") -- lua linter
	local stylua = require("efmls-configs.formatters.stylua") -- lua formatter
	local statix = require("efmls-configs.linters.statix") -- nix linter
	local nixfmt = require("efmls-configs.formatters.nixfmt") -- nix formatter
	local flake8 = require("efmls-configs.linters.flake8") -- python linter
	local black = require("efmls-configs.formatters.black") -- python formatter
	local prettier_d = require("efmls-configs.formatters.prettier_d") -- ts/js/json/docker/html/css/react/svelte/vue formatter
	local eslint_d = require("efmls-configs.linters.eslint_d") -- ts/js/json/react/svelte/vue linter
	local fixjson = require("efmls-configs.formatters.fixjson") -- json formatter
	local shellcheck = require("efmls-configs.linters.shellcheck") -- bash linter
	local shfmt = require("efmls-configs.formatters.shfmt") -- bash formatter
	local hadolint = require("efmls-configs.linters.hadolint") -- docker linter

	local languages = {
		-- { linter, formatter }
		lua = { luacheck, stylua },
		nix = { statix, nixfmt },
		markdown = { prettier_d },
		sh = { shellcheck, shfmt },
		python = { flake8, black },
		docker = { hadolint, prettier_d },

		html = { prettier_d },
		css = { prettier_d },
		javascript = { eslint_d, prettier_d },
		javascriptreact = { eslint_d, prettier_d },
		typescript = { eslint_d, prettier_d },
		typescriptreact = { eslint_d, prettier_d },
		svelte = { eslint_d, prettier_d },
		vue = { eslint_d, prettier_d },

		json = { eslint_d, fixjson },
		jsonc = { eslint_d, fixjson },
	}

	vim.lsp.config("efm", {
		capabilities = capabilities,
		filetypes = vim.tbl_keys(languages),
		init_options = {
			documentFormatting = true,
			documentRangeFormatting = true,
			hover = true,
			documentSymbol = true,
			codeAction = true,
			completion = true,
		},
		settings = {
			languages = languages,
		},
	})

	-- format on save using efm langserver and configured formatters
	local lsp_fmt_group = vim.api.nvim_create_augroup("FormatOnSaveGroup", {})
	vim.api.nvim_create_autocmd("BufWritePre", {
		group = lsp_fmt_group,
		callback = function()
			local efm = vim.lsp.get_clients({ name = "efm" })
			if vim.tbl_isempty(efm) then
				return
			end
			if not vim.g.disable_autoformatting then
				-- async=true causes the file to not be saved after the format
				vim.lsp.buf.format({ name = "efm", async = false })
			end
		end,
	})
end
