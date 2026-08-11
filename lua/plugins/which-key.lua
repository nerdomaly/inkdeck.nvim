-- Leader-key command palette: press <leader> and pause to see available
-- chords with their descriptions (already set via each plugin spec's
-- `keys` entries and lua/config/keymaps.lua).

return {
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
      -- Small, content-sized popup in the corner rather than a
      -- full-width bar, to keep footprint minimal in a zen-mode setup.
      preset = "helix",
    },
  },
}
