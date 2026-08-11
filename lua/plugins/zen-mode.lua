-- Focus mode: centers the buffer and dims everything but the paragraph
-- you're on. Twilight only runs while zen mode is active.

return {
  {
    "folke/zen-mode.nvim",
    dependencies = { "folke/twilight.nvim" },
    cmd = "ZenMode",
    keys = {
      { "<leader>zz", "<cmd>ZenMode<cr>", desc = "Toggle zen mode" },
    },
    opts = {
      on_open = function()
        require("twilight").enable()
      end,
      on_close = function()
        require("twilight").disable()
      end,
    },
  },
  {
    "folke/twilight.nvim",
    cmd = { "Twilight", "TwilightEnable", "TwilightDisable" },
    opts = {
      -- Twilight indexes the treesitter parser for whatever buffer it
      -- enters without checking for nil, which crashes (E5108) on any
      -- buffer without one attached: an empty buffer, a non-markdown
      -- file, or a special-filetype popup from telescope/oil/which-key
      -- opened while zen mode is active. Falls back to dimming a fixed
      -- window of lines around the cursor instead of exact paragraph
      -- boundaries, but never crashes.
      treesitter = false,
    },
  },
}
