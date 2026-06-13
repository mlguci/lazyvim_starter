-- Local patches (patches/<plugin>/*.patch, e.g. the claudecode.nvim
-- climbing-cursor fix) are reverted before Lazy checks out new commits and
-- re-applied afterwards, so they survive :Lazy update/sync/restore.
local patch_script = vim.fn.stdpath("config") .. "/scripts/plugin-patches.sh"

local function run_patches(action)
  local out = vim.fn.system({ patch_script, action })
  if vim.v.shell_error ~= 0 then
    vim.notify("plugin-patches.sh " .. action .. " failed:\n" .. out, vim.log.levels.ERROR)
  end
end

vim.api.nvim_create_autocmd("User", {
  pattern = { "LazyUpdatePre", "LazySyncPre", "LazyRestorePre" },
  callback = function()
    run_patches("revert")
  end,
})

vim.api.nvim_create_autocmd("User", {
  pattern = { "LazyUpdate", "LazySync", "LazyRestore", "LazyInstall" },
  callback = function()
    run_patches("apply")
  end,
})

return {
  {
    "coder/claudecode.nvim",
    keys = {
      { "<C-\\>", "<Cmd>ClaudeCode<CR>", mode = { "n", "t" }, desc = "Toggle Claude" },
    },
    opts = {
      terminal = {
        snacks_win_opts = {
          keys = {
            -- LazyVim adds <C-/>/<C-_> = "hide" to all snacks terminals;
            -- override them so they toggle the toggleterm float (like
            -- everywhere else) instead of closing the Claude window
            hide_slash = {
              "<C-/>",
              function()
                require("toggleterm") -- ensure lazy-loaded so the command exists
                vim.cmd("ToggleTerm direction=float")
              end,
              mode = { "t", "n" },
              desc = "Toggle Terminal (float)",
            },
            hide_underscore = {
              "<C-_>",
              function()
                require("toggleterm")
                vim.cmd("ToggleTerm direction=float")
              end,
              mode = { "t", "n" },
              desc = "which_key_ignore",
            },
            claude_close_jj = {
              "jj",
              function()
                -- Toggle hides the window but keeps the Claude session alive
                vim.cmd("ClaudeCode")
              end,
              mode = "t",
              desc = "Close Claude window",
            },
          },
        },
      },
    },
  },
}
