return {
    "akinsho/toggleterm.nvim",
    version = "*",
    config = function()
        local toggleterm = require("toggleterm")
        toggleterm.setup({

        })

        local keymap = vim.keymap
        keymap.set("n", "<leader>yf", ":ToggleTerm direction=float<CR>", { desc = "Open a floating terminal window" })
        keymap.set("n", "<leader>yb", ":ToggleTerm <CR>", { desc = "Open a bototm terminal window" })

        keymap.set("v", "<space>s", ":ToggleTermSendVisualLines<CR>", { desc = "Send lines to terminal" })
    end,
}
