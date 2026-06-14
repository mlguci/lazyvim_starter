return {
  {
    "NeogitOrg/neogit",
    dependencies = {
      "nvim-lua/plenary.nvim", -- required
      "sindrets/diffview.nvim", -- optional: enhanced diff/merge UI
      "folke/snacks.nvim", -- optional: pickers/input (already in LazyVim)
    },
    cmd = "Neogit",
    -- Coexists with LazyVim's bundled lazygit (<leader>gg via Snacks).
    -- Mnemonic: "m" for magit, avoiding LazyVim's taken <leader>g* keys.
    keys = {
      { "<leader>gm", function() require("neogit").open() end, desc = "Neogit" },
      { "<leader>gM", function() require("neogit").open({ kind = "split" }) end, desc = "Neogit (split)" },
    },
    opts = {
      -- Let Snacks handle prompts/pickers, consistent with the rest of LazyVim.
      integrations = {
        diffview = true,
        snacks = true,
      },
    },
  },
}
