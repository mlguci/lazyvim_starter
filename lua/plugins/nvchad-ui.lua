return {
  { "nvim-lualine/lualine.nvim", enabled = false },
  { "akinsho/bufferline.nvim", enabled = false },
  { "folke/noice.nvim", enabled = false },

  {
    "nvchad/base46",
    lazy = false,
    priority = 1000,
    build = function()
      require("base46").load_all_highlights()
    end,
  },

  { "nvchad/volt", lazy = true },

  {
    "nvchad/ui",
    lazy = false,
    priority = 900,
    dependencies = { "nvim-lua/plenary.nvim", "nvchad/volt", "nvchad/base46" },
    config = function()
      require("nvchad")
    end,
  },
}
