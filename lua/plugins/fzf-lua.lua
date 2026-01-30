-- fzf wrapper (like telescope but faster).
return {
	"ibhagwan/fzf-lua",
	lazy = false,
	dependencies = { "echasnovski/mini.icons" },
	config = function()
		local FzfLua = require("fzf-lua")
		FzfLua.setup({
			defaults = {
				-- copen = false,
			},
			keymap = {
				fzf = {
					["ctrl-q"] = "select-all+accept",
				},
			},
		})
		FzfLua.register_ui_select()
	end,
}
