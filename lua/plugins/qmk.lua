return {
	"codethread/qmk.nvim",
	config = function()
		local conf = {
			name = "cosmos",
			variant = "zmk",
			layout = {
				"_ x x x x x x x _ x x x x x x x",
				"_ x x x x x x x _ x x x x x x x",
				"_ x x x x x x x _ x x x x x x x",
				"_ x x x x x x x _ x x x x x x x",
				"_ x x x x x x x _ x x x x x x x",
				"_ _ _ x x _ _ _ _ _ _ _ x x _ _",
				"_ _ _ _ _ x x x _ x x x _ _ _ _",
				"_ _ _ _ _ _ x x _ x x _ _ _ _ _",
			},
		}
		require("qmk").setup(conf)
	end,
}
