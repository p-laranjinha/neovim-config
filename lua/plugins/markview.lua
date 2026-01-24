return {
    "OXY2DEV/markview.nvim",
    lazy = false,
    config = function()
        require("markview").setup({
            preview = {
                icon_provider = "devicons",
            }
        })
        vim.api.nvim_set_keymap("n", "<leader>tm", "<CMD>Markview<CR>", { desc = "Toggle markview globally" })
    end,
}

