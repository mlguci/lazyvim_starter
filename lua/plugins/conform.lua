return { -- Autoformat
  "stevearc/conform.nvim",
  lazy = false,
  opts = {
    notify_on_error = true,
    formatters_by_ft = {
      lua = { "stylua" },
      python = { "ruff" },
      sh = { "shfmt" },
      c = { "clang_format" },
      -- Conform can also run multiple formatters sequentially
      -- python = { "isort", "black" },
      --
      -- You can use a sub-list to tell conform to run *until* a formatter
      -- is found.
      -- javascript = { { "prettierd", "prettier" } },
    },
    formatters = {
      clang_format = {
        prepend_args = { "--style=file", "--fallback-style=LLVM" },
      },
      shfmt = {
        prepend_args = { "-i", "4" },
      },
    },
  },
}
