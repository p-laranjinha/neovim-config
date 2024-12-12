-- Highlight, edit, and navigate code.
return {
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		opts = {
			ensure_installed = { "bash", "c", "diff", "html", "lua", "luadoc", "markdown", "vim", "vimdoc" },
			-- Autoinstall languages that are not installed.
			auto_install = true,
			highlight = {
				enable = true,
				-- Some languages depend on vim's regex highlighting system
				--  (such as Ruby) for indent rules.
				-- If I am experiencing weird indenting issues, add the
				--  language to the list of additional_vim_regex_highlighting
				--  and disabled languages for indent.
				additional_vim_regex_highlighting = { "ruby" },
			},
			indent = { enable = true, disable = { "ruby" } },

			-- Allows for shortcuts to select incrementally bigger scopes in
			--  visual mode with "grn", "grc" and "grm".
			--incremental_selection = { enable = true },
		},
		config = function(_, opts)
			-- Prefer git instead of curl in order to improve connectivity in
			--  some environments.
			require("nvim-treesitter.install").prefer_git = true
			---@diagnostic disable-next-line: missing-fields
			require("nvim-treesitter.configs").setup(opts)
		end,
	},
	{
		-- Show my current context at the top of the screen
		"nvim-treesitter/nvim-treesitter-context",
		config = function()
			require("treesitter-context")
		end,
	},
}
-- Look into treesitter + textobjects: https://github.com/nvim-treesitter/nvim-treesitter-textobjects
