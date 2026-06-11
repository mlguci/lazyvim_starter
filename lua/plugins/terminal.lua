return {
  -- Note: ctrl-/ and ctrl-_ are the same key, but default config is done in
  --       terms of ctrl-_, so we should override that
  -- Disable Snacks terminal on C-/
  {
    "folke/snacks.nvim",
    keys = {
      { "<C-/>", false, mode = { "n", "t", "i" } },
      { "<C-_>", false, mode = { "n", "t", "i" } },
    },
  },
  -- Toggleterm with C-/ as toggle
  {
    "akinsho/toggleterm.nvim",
    version = "*",
    -- Override LazyVim's <C-/> (Snacks terminal) with toggleterm float.
    -- Most terminals send <C-/> as <C-_>, so bind both.
    keys = {
      { "<C-/>", "<Cmd>ToggleTerm direction=float<CR>", mode = { "n", "t" }, desc = "Toggle Terminal (float)" },
      { "<C-_>", "<Cmd>ToggleTerm direction=float<CR>", mode = { "n", "t" }, desc = "which_key_ignore" },
    },
    opts = {
      size = function(term)
        if term.direction == "horizontal" then
          return 20
        elseif term.direction == "vertical" then
          return vim.o.columns * 0.4
        end
      end,
      direction = "float",
      open_mapping = [[<C-_>]],
      insert_mappings = true,
      terminal_mappings = true,
    },
    config = function(_, opts)
      require("toggleterm").setup(opts)

      vim.api.nvim_create_autocmd("TermOpen", {
        pattern = "term://*toggleterm#*",
        callback = function()
          local kopts = { buffer = 0 }
          vim.keymap.set("t", "<esc>", [[<C-\><C-n>]], kopts)
          vim.keymap.set("t", "jj", [[<C-\><C-n>]], kopts)
          vim.keymap.set("t", "<C-h>", [[<Cmd>wincmd h<CR>]], kopts)
          vim.keymap.set("t", "<C-j>", [[<Cmd>wincmd j<CR>]], kopts)
          vim.keymap.set("t", "<C-k>", [[<Cmd>wincmd k<CR>]], kopts)
          vim.keymap.set("t", "<C-l>", [[<Cmd>wincmd l<CR>]], kopts)
        end,
      })
    end,
  },
}
