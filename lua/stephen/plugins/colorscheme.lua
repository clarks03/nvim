return {

    -- nord
    -- "shaunsingh/nord.nvim",
    -- priority = 1000,
    -- config = function()
    --     vim.cmd("colorscheme nord")
    -- end

    -- gruvbox
    -- "ellisonleao/gruvbox.nvim",
    -- priority = 1000,
    -- config = function()
    --     vim.cmd("colorscheme gruvbox")
    -- end
    --
    -- kanagawa
    -- "rebelot/kanagawa.nvim",
    -- priority = 1000,
    -- config = function()
    --     vim.cmd("colorscheme kanagawa-dragon")
    -- end

    -- catppuccin
    -- "catppuccin/nvim",
    -- name = "catppuccin",
    -- priority = 1000,
    -- config = function()
    --     vim.cmd("colorscheme catppuccin-mocha")
    -- end,
    

    -- rose-pine
    "rose-pine/neovim",
    name = "rose-pine",
    priority = 1000,
    config = function()
        require("rose-pine").setup({
            styles = {
                transparency = true,
            }
        })
        vim.cmd("colorscheme rose-pine")
    end,
    
    -- binary
    -- "jackplus-xyz/binary.nvim",
    -- name = "binary",
    -- priority = 1000,
    -- config = function()
    --     vim.cmd("colorscheme binary")
    -- end,

}
