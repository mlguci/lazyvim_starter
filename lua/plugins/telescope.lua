return {
  "nvim-telescope/telescope.nvim",
  keys = {
    {
      "<leader>uC",
      LazyVim.pick("colorscheme", { enable_preview = true, ignore_builtins = true }),
      desc = "Colorscheme with Preview",
    },
  },
}
