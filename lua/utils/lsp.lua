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

	-- Enable inlay hints on buffers that support it
	-- if client and client.server_capabilities.inlayHintProvider and vim.lsp.inlay_hint then
	-- 	vim.lsp.inlay_hint.enable()
	-- end

	if client.name == "efm" then
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
