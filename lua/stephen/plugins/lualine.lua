return {
  "nvim-lualine/lualine.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    local lualine = require("lualine")

    -- Neovim 0.12 returns { link = "..." } unless link=false, which
    -- resolves through the link chain to the concrete fg/bg values.
    local function hl(name, attr, fallback)
      local g = vim.api.nvim_get_hl(0, { name = name, link = false })
      local value = g[attr]
      if value then
        return string.format("#%06x", value)
      end
      return fallback
    end

    local function get_colors()
      return {
        bg = hl("StatusLine", "bg", "#3c3836"),
        fg = hl("Normal", "fg", "#ebdbb2"),
        yellow = hl("DiagnosticWarn", "fg", "#fabd2f"),
        cyan = hl("DiagnosticInfo", "fg", "#8ec07c"),
        darkblue = hl("Directory", "fg", "#458588"),
        green = hl("Added", "fg", hl("Type", "fg", "#b8bb26")),
        orange = hl("Constant", "fg", "#fe8019"),
        violet = hl("Statement", "fg", "#d3869b"),
        magenta = hl("Special", "fg", "#b16286"),
        blue = hl("Function", "fg", "#83a598"),
        red = hl("DiagnosticError", "fg", "#fb4934"),
      }
    end

    local conditions = {
      buffer_not_empty = function()
        return vim.fn.empty(vim.fn.expand('%:t')) ~= 1
      end,
      hide_in_width = function ()
        return vim.fn.winwidth(0) > 80
      end,
      check_git_workspace = function()
        local filepath = vim.fn.expand('%:p:h')
        local gitdir = vim.fn.finddir('.git', filepath .. ';')
        return gitdir and #gitdir > 0 and #gitdir < #filepath
      end,
    }

    local function build_config()
      local colors = get_colors()

      local config = {
        options = {
          component_separators = '',
          section_separators = '',
          theme = {
            -- We are going to use lualine_c and lualine_x as left and
            -- right section. Both are highlighted by c theme. So we
            -- are just setting default looks of statusline
            normal = { c = { fg = colors.fg, bg = colors.bg } },
            inactive = { c = { fg = colors.fg, bg = colors.bg } },
          },
        },
        sections = {
          lualine_a = {},
          lualine_b = {},
          lualine_y = {},
          lualine_z = {},
          lualine_c = {},
          lualine_x = {},
        },
        inactive_sections = {
          lualine_a = {},
          lualine_b = {},
          lualine_y = {},
          lualine_z = {},
          lualine_c = {},
          lualine_x = {},
        },
      }

      local function ins_left(component)
        table.insert(config.sections.lualine_c, component)
      end

      local function ins_right(component)
        table.insert(config.sections.lualine_x, component)
      end

      ins_left {
        function()
          return '▊'
        end,
        color = { fg = colors.blue },
        padding = { left = 0, right = 1 },
      }

      ins_left {
        function()
          return '󰕈'
        end,
        color = function()
          local c = get_colors()
          local mode_color = {
            n = c.red,
            i = c.green,
            v = c.blue,
            [''] = c.blue,
            V = c.blue,
            c = c.magenta,
            no = c.red,
            s = c.orange,
            S = c.orange,
            [''] = c.orange,
            ic = c.yellow,
            R = c.violet,
            Rv = c.violet,
            cv = c.red,
            ce = c.red,
            r = c.cyan,
            rm = c.cyan,
            ['r?'] = c.cyan,
            ['!'] = c.red,
            t = c.red,
          }
          return { fg = mode_color[vim.fn.mode()] }
        end,
        padding = { right = 1 },
      }

      ins_left {
        -- filesize component
        'filesize',
        cond = conditions.buffer_not_empty,
      }

      ins_left {
        'filename',
        cond = conditions.buffer_not_empty,
        color = { fg = colors.magenta, gui = 'bold' },
      }

      ins_left { 'location' }

      ins_left {
        'progress',
        color = { fg = colors.fg, gui = 'bold' },
      }

      ins_left {
        'diagnostics',
        sources = { 'nvim_diagnostic' },
        symbols = { error = ' ', warn = ' ', info = ' ' },
        diagnostics_color = {
          error = { fg = colors.red },
          warn = { fg = colors.yellow },
          info = { fg = colors.cyan },
        },
      }

      ins_left {
        function()
          return '%='
        end,
      }

      ins_left {
        function()
          local msg = 'No Active Lsp'
          local buf_ft = vim.api.nvim_get_option_value('filetype', { buf = 0 })
          local clients = vim.lsp.get_clients()
          if next(clients) == nil then
            return msg
          end
          for _, client in ipairs(clients) do
            local filetypes = client.config.filetypes
            if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
              return client.name
            end
          end
          return msg
        end,
        icon = ' LSP:',
        color = { fg = colors.fg, gui = 'bold' },
      }

      ins_right {
        'o:encoding',
        fmt = string.upper,
        cond = conditions.hide_in_width,
        color = { fg = colors.green, gui = 'bold' },
      }

      ins_right {
        'fileformat',
        fmt = string.upper,
        icons_enabled = false,
        color = { fg = colors.green, gui = 'bold' },
      }

      ins_right {
        'branch',
        icon = '',
        color = { fg = colors.violet, gui = 'bold' },
      }

      ins_right {
        'diff',
        symbols = { added = ' ', modified = '󰝤 ', removed = ' ' },
        diff_color = {
          added = { fg = colors.green },
          modified = { fg = colors.orange },
          removed = { fg = colors.red },
        },
        cond = conditions.hide_in_width,
      }

      ins_right {
        function ()
          return '▊'
        end,
        color = { fg = colors.blue },
        padding = { left = 1 },
      }

      return config
    end

    lualine.setup(build_config())

    vim.api.nvim_create_autocmd("ColorScheme", {
      group = vim.api.nvim_create_augroup("LualineColorschemeRefresh", { clear = true }),
      callback = function()
        lualine.setup(build_config())
      end,
    })
  end,
}
