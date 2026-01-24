return {
    {
        "EdenEast/nightfox.nvim",
        lazy = false, -- Don't lazy load.
        priority = 999, -- One of the first to be loaded.
        config = function()
            -- load duskfox palette
            local palette = require("nightfox.palette").load("carbonfox")

            require("nightfox").setup({
                -- options = {
                --     transparent = true,
                -- },
                -- groups = {
                --     carbonfox = {
                --         Visual = { bg = palette.bg1 },
                --     },
                -- },
            })
            vim.cmd("colorscheme carbonfox")
        end,
    },
    {
        "xiyaowong/nvim-transparent",
        lazy = false,
        priority = 999,
    },
    -- Other cool themes:
    { "rebelot/kanagawa.nvim", lazy = false, priority = 999 },
    { "folke/tokyonight.nvim", lazy = false, priority = 999 },
    { "tiagovla/tokyodark.nvim", lazy = false, priority = 999 },
    { "Shatur/neovim-ayu", lazy = false, priority = 999 },
    { "Mofiqul/vscode.nvim", lazy = false, priority = 999 },
}
