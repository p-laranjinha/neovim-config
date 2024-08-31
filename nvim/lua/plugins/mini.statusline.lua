-- Simple statusline.
return {
	{
		"echasnovski/mini.statusline",
		config = function()
			local statusline = require("mini.statusline")
			-- Set use_icons to true if I have a Nerd Font.
			statusline.setup({ use_icons = vim.g.have_nerd_font })

			-- Set the section for cursor location to LINE:COLUMN.
			---@diagnostic disable-next-line: duplicate-set-field
			statusline.section_location = function()
				return "%2l:%-2v"
			end
		end,
	},
}
