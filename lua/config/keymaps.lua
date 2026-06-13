-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- LazyVim maps <c-/>/<c-_> in terminal mode to Snacks.terminal globally;
-- remove them so they don't fire inside the Claude window. Toggleterm
-- terminals get their own buffer-local mappings (see plugins/terminal.lua).
pcall(vim.keymap.del, "t", "<c-/>")
pcall(vim.keymap.del, "t", "<c-_>")
