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
    opts = {},
  },
}
