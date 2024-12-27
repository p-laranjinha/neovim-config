-- Language Server Protocol (LSP) Configuration & Plugins.
return {
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			-- Automatically install LSPs and related tools to stdpath for Neovim.
			-- Must be loaded before dependants.
			{ "williamboman/mason.nvim", config = true },
			"williamboman/mason-lspconfig.nvim",
			"WhoIsSethDaniel/mason-tool-installer.nvim",

			-- Useful status updates for LSP in the bottom right corner.
			--  `opts = {}` is the same as calling `require('fidget').setup({})`
			{ "j-hui/fidget.nvim", opts = {} },

			-- Configures Lua LSP for the Neovim config, runtime and plugins used for
			--  completion, annotations and signatures of Neovim apis.
			-- This plugin is no longer receiving updates but "lazydev" doesn't
			--  work as well as just a straight replacement. (globals are not
			--  a different color and `:LspRestart` breaks it)
			{ "folke/neodev.nvim", opts = {} },

			-- Allows extra capabilities provided by nvim-cmp
			"hrsh7th/cmp-nvim-lsp",
		},
		config = function()
			--  This function gets run when an LSP attaches to a particular buffer.
			vim.api.nvim_create_autocmd("LspAttach", {
				group = vim.api.nvim_create_augroup("lsp-attach", { clear = true }),
				callback = function(event)
					local map = function(keys, func, desc)
						vim.keymap.set("n", keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
					end

					-- Jump to the definition of the word under the cursor. This is where
					--  a variable was first declared, or where a function is defined, etc.
					-- To jump back, press <C-t>.
					map("gd", require("telescope.builtin").lsp_definitions, "Goto [d]efinition")

					-- Find references for the word under the cursor.
					map("gr", require("telescope.builtin").lsp_references, "Goto [r]eferences")

					-- Jump to the implementation of the word under the cursor.
					-- Useful when the language has ways of declaring types without an actual implementation.
					map("gI", require("telescope.builtin").lsp_implementations, "Goto [I]mplementation")

					-- Jump to the type of the word under the cursor
					-- Useful when I'm not sure what type a variable is and I want to see
					--  the definition of its type, not where it was defined.
					map("gt", require("telescope.builtin").lsp_type_definitions, "Goto [t]ype definition")

					-- Fuzzy find all the symbols in the current document.
					--  Symbols are things like variables, functions, types, etc.
					map("<leader>ds", require("telescope.builtin").lsp_document_symbols, "Document [s]ymbols")

					-- Fuzzy find all the symbols in the current workspace.
					--  Similar to document symbols, except it searches over the entire project.
					map("<leader>ws", require("telescope.builtin").lsp_dynamic_workspace_symbols, "Workspace [s]ymbols")

					-- Rename the variable under the cursor.
					--  Most Language Servers support renaming across files, etc.
					map("<leader>rn", vim.lsp.buf.rename, "Re[n]ame")

					-- Execute a code action. Usually the cursor needs to be on top of an
					--  error or a suggestion from the LSP for this to activate.
					map("<leader>ca", vim.lsp.buf.code_action, "Code [a]ction")

					-- Opens a popup that displays documentation about the word under the
					--  cursor.
					map("K", vim.lsp.buf.hover, "Hover documentation")

					--  In C this would take me to the header.
					map("gD", vim.lsp.buf.declaration, "Goto [D]eclaration")

					-- The following two autocommands are used to highlight references of
					--  the word under the cursor when the cursor rests there for a
					--  little while.
					-- When the cursor is moved, the highlights will be cleared (the
					--  second autocommand).
					local client = vim.lsp.get_client_by_id(event.data.client_id)
					if client and client.server_capabilities.documentHighlightProvider then
						local highlight_augroup = vim.api.nvim_create_augroup("lsp-highlight", { clear = false })
						vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
							buffer = event.buf,
							group = highlight_augroup,
							callback = vim.lsp.buf.document_highlight,
						})

						vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
							buffer = event.buf,
							group = highlight_augroup,
							callback = vim.lsp.buf.clear_references,
						})

						vim.api.nvim_create_autocmd("LspDetach", {
							group = vim.api.nvim_create_augroup("lsp-detach", { clear = true }),
							callback = function(event2)
								vim.lsp.buf.clear_references()
								vim.api.nvim_clear_autocmds({ group = "lsp-highlight", buffer = event2.buf })
							end,
						})
					end

					-- The following autocommand is used to toggle inlay hints in the
					--  code, if the language server I am using supports them.
					-- This may be unwanted, since they displace some of the code.
					if client and client.server_capabilities.inlayHintProvider and vim.lsp.inlay_hint then
						vim.lsp.inlay_hint.enable()
						map("<leader>th", function()
							vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({}))
						end, "Toggle inlay [h]ints")
					end
				end,
			})

			-- LSP servers and clients are able to communicate to each other what features they support.
			--  By default, Neovim doesn't support everything that is in the LSP specification.
			--  When nvim-cmp, luasnip, etc. are added Neovim now has *more* capabilities.
			--  So, create new capabilities with nvim cmp, and then broadcast that to the servers.
			local capabilities = vim.lsp.protocol.make_client_capabilities()
			capabilities = vim.tbl_deep_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())

			-- Enable the following language servers. They will automatically be installed.
			-- Add any additional override configuration in the following tables. Available keys are:
			--  - cmd (table): Override the default command used to start the server.
			--  - filetypes (table): Override the default list of associated filetypes for the server.
			--  - capabilities (table): Override fields in capabilities. Can be used to disable certain LSP features.
			--  - settings (table): Override the default settings passed when initializing the server.
			--  For example, to see the options for `lua_ls`, go to: https://luals.github.io/wiki/settings/
			local servers = {
				-- See `:help lspconfig-all` for a list of all the pre-configured LSPs.
				-- Some languages (like typescript) have entire language plugins that can be useful:
				--  https://github.com/pmizio/typescript-tools.nvim
				--  But for many setups, the LSP (`tsserver`) will work just fine.

				ts_ls = {},
				lua_ls = {
					settings = {
						Lua = {
							completion = {
								callSnippet = "Replace",
							},
							-- Toggle below to ignore Lua_LS's noisy `missing-fields` warnings.
							--diagnostics = { disable = { 'missing-fields' } },
						},
					},
				},
				pyright = {
					settings = {
						python = {
							analysis = {
								autoSearchPaths = true,
								autoImportCompletions = true,
								diagnosticMode = "workspace",
								useLibraryCodeForTypes = true,
							},
						},
					},
				},
			}

			require("mason").setup()
			require("mason-tool-installer").setup({ ensure_installed = { "stylua" } })
			require("mason-lspconfig").setup({
				ensure_installed = vim.tbl_keys(servers or {}),
				automatic_installation = { --[[ exclude = { "pylsp", "pyright" } ]]
				},
				handlers = {
					function(server_name)
						local server = servers[server_name] or {}
						-- This handles overriding only values explicitly passed
						--  by the server configuration above.
						-- Useful when disabling certain features of an LSP
						--  (for example, turning off formatting for tsserver).
						server.capabilities = vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {})
						require("lspconfig")[server_name].setup(server)
					end,
				},
			})
		end,
	},
}
