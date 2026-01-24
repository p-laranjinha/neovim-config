-- Display keybindings as you type.
return {
	"folke/which-key.nvim",
	event = "VeryLazy",
	opts = {},
	keys = {
		{
			"<leader>?",
			function()
				require("which-key").show({ global = false })
			end,
			desc = "Buffer Local Keymaps (which-key)",
		},
	},
    config = function()
        require("which-key").add({
            {"<leader>f", group = "Find" },
        })
    end,
}
