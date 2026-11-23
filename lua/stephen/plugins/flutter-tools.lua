return {
  "nvim-flutter/flutter-tools.nvim",
  init = function()
    vim.api.nvim_create_autocmd("LspAttach", {
      callback = function(ev)
        vim.lsp.document_color.enable(true, { bufnr = ev.buf })
      end,
    })
  end,
  lazy = false,
  dependencies = {
    "nvim-lua/plenary.nvim",
    "stevearc/dressing.nvim",
  },
  keys = {
    { "<leader>Fs", "<cmd>FlutterRun<CR>", desc = "Flutter run" },
    { "<leader>Fr", "<cmd>FlutterRestart<CR>", desc = "Flutter restart" },
    { "<leader>Fd", "<cmd>FlutterDevices<CR>", desc = "Flutter devices" },
    { "<leader>Ft", "<cmd>FlutterLogToggle<CR>", desc = "Toggle Flutter log" },
    { "<leader>Fq", "<cmd>FlutterQuit<CR>", desc = "Flutter quit" },
    { 
      "<leader>Fb",
      function() 
        local Terminal = require("toggleterm.terminal").Terminal

        Terminal:new({
          cmd = "flutter build apk --release"
          .. "&& /mnt/c/Windows/explorer.exe $(wslpath -w build/app/outputs/flutter-apk/)",
          dir = vim.fn.getcwd(),
          direction = "horizontal",
          close_on_exit = false,
          on_open = function(term)
            vim.cmd("startinsert!")
            vim.keymap.set("n", "q", "<cmd>close<CR>", { buffer = term.bufnr, silent = true })
        end,
        }):toggle()
      end,
      desc = "Flutter build APK and open release folder",
    },
    { "<leader>Fw", function()
      vim.cmd('FlutterRun -d web-server --web-hostname=0.0.0.0 --web-port=8080')
    end, desc = 'Run flutter web server' },
  },
  opts = {
    flutter_path = "/home/sclark/development/flutter/bin/flutter",
    dev_log = {
      open_cmd = "botright 5split",
    },
  },
  config = true,
}
