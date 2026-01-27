-- WARN: These keymaps are here so they only apply when the LSP attaches and don't clutter otherwise.

local M = {}

M.on_attach = function(event)
	local client = vim.lsp.get_client_by_id(event.data.client_id)
	if not client then
		return
	end

	-- Used by lualine to know when to display symbols
	vim.b.has_lsp = true

	local bufnr = event.buf
	local keymap = function(mode, lhs, rhs, opts)
		vim.keymap.set(
			mode,
			lhs,
			rhs,
			vim.tbl_extend("keep", opts, {
				noremap = true, -- prevent recursive mapping
				silent = true, -- don't print the command to the cli
				buffer = bufnr, -- restrict the keymap to the local buffer number
			})
		)
	end

	-- Rename the variable under the cursor.
	--  Most Language Servers support renaming across files, etc.
	keymap("n", "<leader>r", vim.lsp.buf.rename, { desc = "Rename" })
	keymap("n", "<leader>lR", vim.lsp.buf.rename, { desc = "Rename" })

	-- A combination of many of the keymaps below.
	keymap("n", "<leader>lf", "<cmd>FzfLua lsp_finder<CR>", { desc = "Finder (definition, references, ...)" })

	-- Jump to the definition of the word under the cursor. This is where
	--  a variable was first declared, or where a function is defined, etc.
	keymap("n", "<leader>ld", "<cmd>FzfLua lsp_definitions<CR>", { desc = "Definition" })

	-- Find references for the word under the cursor.
	keymap("n", "<leader>lr", "<cmd>FzfLua lsp_references<CR>", { desc = "References" })

	-- Jump to the implementation of the word under the cursor.
	-- Useful when the language has ways of declaring types without an actual implementation.
	keymap("n", "<leader>li", "<cmd>FzfLua lsp_implementations<CR>", { desc = "Implementations" })

	-- Jump to the type of the word under the cursor
	-- Useful when I'm not sure what type a variable is and I want to see
	--  the definition of its type, not where it was defined.
	keymap("n", "<leader>lt", "<cmd>FzfLua lsp_typedefs<CR>", { desc = "Type definitions" })

	-- Fuzzy find all the symbols in the current document.
	--  Symbols are things like variables, functions, types, etc.
	keymap("n", "<leader>ls", "<cmd>FzfLua lsp_document_symbols<CR>", { desc = "Document symbols" })

	-- Fuzzy find all the symbols in the current workspace.
	--  Similar to document symbols, except it searches over the entire project.
	keymap("n", "<leader>lS", "<cmd>FzfLua lsp_workspace_symbols<CR>", { desc = "Workspace symbols" })

	-- Execute a code action (to fix an error or other). Usually the cursor needs to be on top of an
	--  error or a suggestion from the LSP for this to activate.
	keymap("n", "<leader>la", "<cmd>FzfLua lsp_code_actions<CR>", { desc = "Code action" })

	--  In C this would take me to the header
	keymap("n", "<leader>lD", "<cmd>FzfLua lsp_declarations<CR>", { desc = "Declarations" })

	-- Diagnostics
	keymap("n", "[x", function()
		vim.diagnostic.jump({ count = -1, float = true })
	end, { desc = "Diagnostic" })
	keymap("n", "]x", function()
		vim.diagnostic.jump({ count = 1, float = true })
	end, { desc = "Diagnostic" })
	keymap("n", "[X", function()
		vim.diagnostic.jump({ count = -999, float = true })
	end, { desc = "First diagnostic" })
	keymap("n", "]X", function()
		vim.diagnostic.jump({ count = 999, float = true })
	end, { desc = "Last diagnostic" })
	keymap("n", "<leader>xx", function()
		vim.diagnostic.open_float({ scope = "cursor" })
	end, { desc = "Cursor diagnostics" })
	keymap("n", "<leader>xX", function()
		vim.diagnostic.open_float({ scope = "line" })
	end, { desc = "Line diagnostics" })
	keymap("n", "<leader>tv", require("utils.diagnostics").toggle_virtual_lines, { desc = "Diagnostic virtual lines" })
	keymap("n", "<leader>xs", function()
		require("fzf-lua").diagnostics_document()
	end, { desc = "Search document diagnostics" })
	keymap("n", "<leader>xS", function()
		require("fzf-lua").diagnostics_workspace()
	end, { desc = "Search workspace diagnostics" })

	-- Toggles
	keymap("n", "<leader>tx", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", { desc = "Buffer diagnostics" })
	keymap("n", "<leader>tX", "<cmd>Trouble diagnostics toggle<cr>", { desc = "Workspace diagnostics" })
	keymap(
		"n",
		"<leader>ts",
		"<cmd>Trouble lsp_document_symbols toggle focus=false multiline=false win.position=right<cr>",
		{ desc = "LSP Document Symbols" }
	)
	keymap(
		"n",
		"<leader>tl",
		"<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
		{ desc = "LSP definitions, references, ..." }
	)

	-- Order Imports (if supported by the client LSP)
	if client:supports_method("textDocument/codeAction", bufnr) then
		keymap("n", "<leader>lo", function()
			vim.lsp.buf.code_action({
				context = {
					only = { "source.organizeImports" },
					diagnostics = {},
				},
				apply = true,
				bufnr = bufnr,
			})
			-- format after changing import order
			vim.defer_fn(function()
				vim.lsp.buf.format({ bufnr = bufnr })
			end, 50) -- slight delay to allow for the import order to go first
		end, { desc = "Organize imports" })
	end

	-- The following autocommand is used to toggle inlay hints in the
	--  code, if the language server I am using supports them.
	-- This may be unwanted, since they displace some of the code.
	if client and client.server_capabilities.inlayHintProvider and vim.lsp.inlay_hint then
		-- vim.lsp.inlay_hint.enable()
		keymap("n", "<leader>th", function()
			vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
		end, { desc = "Inlay hints" })
	end

	if client.name == "efm" then
		keymap("n", "<leader>tf", function()
			vim.g.autoformat = not vim.g.autoformat
		end, { desc = "Formatting on save" })

		-- format on save using efm langserver and configured formatters
		local lsp_fmt_group = vim.api.nvim_create_augroup("FormatOnSaveGroup", {})
		vim.api.nvim_create_autocmd("BufWritePre", {
			group = lsp_fmt_group,
			callback = function()
				local efm = vim.lsp.get_clients({ name = "efm" })
				if vim.tbl_isempty(efm) then
					return
				end
				if vim.g.autoformat then
					-- async=true causes the file to not be saved after the format
					vim.lsp.buf.format({ name = "efm", async = false })
				end
			end,
		})
	end
end

return M
