return {
  "folke/trouble.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons", "folke/todo-comments.nvim" },
  opts = {},
  cmd = "Trouble",
  keys = {
    { "<leader>xw", "<cmd>Trouble diagnostics toggle<CR>", desc = "Open trouble workplace diagnostics" },
    { "<leader>xd", "<cmd>Trouble diagnostics toggle filter.buf=0<CR>", desc = "Open trouble document diagnostics" },
    { "<leader>xq", "<cmd>Trouble qflist toggle<CR>", desc = "Open trouble quickfist list" },
    { "<leader>xl", "<cmd>Trouble locfist toggle<CR>", desc = "Open trouble location list" },
    { "<leader>xt", "<cmd>Trouble todo toggle<CR>", desc = "Open todos in trouble" },
  },
}
