-- Library of 40+ independent Lua modules.
return {
	-- Improve selection of 'inside' or 'around' objects.
	{ "echasnovski/mini.ai", version = "*", opts = {} },
	-- Improved commenting.
	{ "echasnovski/mini.comment", version = "*", opts = {} },
	-- Move text using Alt.
	{ "echasnovski/mini.move", version = "*", opts = {} },
	-- Add, delete, replace, find, highlight surrounding (like pair of parenthesis, quotes, etc.).
	{ "echasnovski/mini.surround", version = "*", opts = {} },
	-- Autohighlight word under cursor.
	{ "echasnovski/mini.cursorword", version = "*", opts = {} },
	-- Visualize and work with indent scope.
	{ "echasnovski/mini.indentscope", version = "*", opts = {} },
	-- Highlight trailing whitespace.
	{ "echasnovski/mini.trailspace", version = "*", opts = {} },
	-- Buffer removing (unshow, delete, wipeout), which saves window layout.
	{ "echasnovski/mini.bufremove", version = "*", opts = {} },
	-- Prettier notifications.
	{ "echasnovski/mini.notify", version = "*", opts = {} },
	-- Icons for other plugins + colors for which-key.
	{
		"echasnovski/mini.icons",
		version = "*",
		opts = {},
		config = function()
			-- To add icons to nvim-tree.
			require("mini.icons").mock_nvim_web_devicons()
		end,
	},
}
