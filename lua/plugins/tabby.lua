return {
  -- Disable LazyVim's default bufferline (buffer-as-tabs).
  { "akinsho/bufferline.nvim", enabled = false },

  -- Use tabby.nvim to render Vim's real tabpages instead.
  {
    "nanozuki/tabby.nvim",
    event = "VeryLazy",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    init = function()
      -- Always show the tabline, even with a single tab.
      vim.o.showtabline = 2
    end,
    opts = {
      preset = "active_wins_at_end",
      option = {
        theme = {
          fill = "TabLineFill", -- tabline background
          head = "TabLine", -- head element highlight
          current_tab = "TabLineSel", -- current tab label highlight
          tab = "TabLine", -- other tab label highlight
          win = "TabLine", -- window highlight
          tail = "TabLine", -- tail element highlight
        },
        nerdfont = true, -- whether use nerdfont
        lualine_theme = nil, -- lualine theme name
        tab_name = {
          name_fallback = function(tabid)
            local api = require("tabby.module.api")
            local win = api.get_tab_current_win(tabid)
            local buf = api.get_win_buf(win)
            local name = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(buf), ":t")
            return name ~= "" and name or "[No Name]"
          end,
        },
        buf_name = {
          mode = "unique", -- or 'relative', 'tail', 'shorten'
        },
      },
    },
  },
}
