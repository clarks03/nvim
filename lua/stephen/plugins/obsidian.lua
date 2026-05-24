return {
    "epwalsh/obsidian.nvim",
    version = "*",  -- recommended, use latest release instead of latest commit
    lazy = true,
    ft = "markdown",
    dependencies = {
        "nvim-lua/plenary.nvim",
    },
    opts = {
        workspaces = {
            {
                name = "Downloads-2024",
                path = "~/Downloads",
            },
            {
                name = "School",
                path = "~/School",
            },
        },

        follow_url_func = function(url)
            vim.fn.jobstart({ "xdg-open", url })
        end,
    },
}
