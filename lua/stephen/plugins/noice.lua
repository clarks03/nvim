return {
  "folke/noice.nvim",
  event = "VeryLazy",
  opts = {
    -- add any options here
    routes = {
      {
        filter = {
          event = "msg_show",
          any = {
            { find = "NvimTree" },
            { find = "File Created" },
          },
        },
        opts = { skip = true },
      },
      -- Other commonly annoying notifications you might want to supress:
      {
        filter = {
          event = "msg_show",
          any = {
            { find = "%d+L, %d+B" },  -- written file info
            { find = "^%d+ lines" },  -- e.g.: "12 lines yanked"
            { find = "already at newest" },  -- undo/redo at boundary
          },
        },
        opts = { skip = true },
      },
    },
  },
  dependencies = {
    "MunifTanjim/nui.nvim",
    "rcarriga/nvim-notify",
  }
}
