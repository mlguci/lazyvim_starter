-- Dim inactive windows so the focused split (editor, terminal, claude, ...)
-- clearly stands out. https://github.com/levouh/tint.nvim
return {
  "levouh/tint.nvim",
  event = "VeryLazy",
  opts = {
    tint = -80, -- darken inactive windows (more negative = darker)
    saturation = 0.1, -- and desaturate them a touch
    -- Keep separators/statusline crisp instead of dimming them too.
    highlight_ignore_patterns = { "WinSeparator", "Status.*" },
  },
}
