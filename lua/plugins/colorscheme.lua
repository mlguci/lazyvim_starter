return {
  {
    "folke/snacks.nvim",
    opts = {
      picker = {
        sources = {
          colorschemes = {
            transform = function(item)
              -- Drop anything that lives under $VIMRUNTIME/colors
              if item.file and vim.startswith(item.file, vim.env.VIMRUNTIME) then
                return false
              end
              return true
            end,
          },
        },
      },
    },
  },
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    opts = {
      flavour = "mocha", -- latte, frappe, macchiato, mocha
      highlight_overrides = {
        all = function(colors)
          return {
            WinSeparator = { fg = colors.surface2, bg = colors.mantle },
          }
        end,
      },
    },
  },
  { "projekt0n/github-nvim-theme", name = "github-theme" },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "catppuccin",
    },
  },
}
