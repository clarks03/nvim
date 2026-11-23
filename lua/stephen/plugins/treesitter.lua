return {
  "nvim-treesitter/nvim-treesitter",
  branch = "main",
  event = { "BufReadPre", "BufNewFile" },
  build = ":TSUpdate",
  config = function()
    local treesitter = require("nvim-treesitter")

    treesitter.install({
      "json",
      "javascript",
      "typescript",
      "tsx",
      "yaml",
      "html",
      "css",
      "markdown",
      "markdown_inline",
      "bash",
      "lua",
      "vim",
      "dockerfile",
      "python",
      "gitignore",
      "query",
      "vimdoc",
      "c",
      "prisma",
      "dart",
    })

    vim.api.nvim_create_autocmd("FileType", {
      callback = function(ev)
        pcall(vim.treesitter.start)
        vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
      end,
    })

    vim.treesitter.language.register("bash", "zsh")
  end,
}
