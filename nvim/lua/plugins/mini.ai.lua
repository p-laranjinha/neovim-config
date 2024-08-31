-- Better Around/Inside text objects.
-- Examples:
--  - va)  - [V]isually select [A]round [)]paren
--  - yinq - [Y]ank [I]nside [N]ext [']quote
--  - ci'  - [C]hange [I]nside [']quote
return {
	{
		"echasnovski/mini.ai",
		config = function()
			require("mini.ai").setup({ n_lines = 500 })
		end,
	},
}
