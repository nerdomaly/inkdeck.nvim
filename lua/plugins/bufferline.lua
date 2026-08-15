-- Tab strip across the top for switching between open documents. Stays
-- hidden until there's a second buffer to switch between -- a single open
-- document (the common case here) and the mini.starter dashboard both stay
-- clutter-free. Hidden entirely while zen mode is active (see zen-mode.lua).

return {
  {
    "akinsho/bufferline.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    -- Needs to be ready before a second buffer might exist, not deferred
    -- to a keymap/cmd like most plugins here (same reasoning as
    -- which-key.lua's VeryLazy use).
    event = "VeryLazy",
    keys = {
      { "]b", "<cmd>BufferLineCycleNext<cr>", desc = "Next buffer" },
      { "[b", "<cmd>BufferLineCyclePrev<cr>", desc = "Previous buffer" },
      { "<leader>bd", "<cmd>bdelete<cr>", desc = "Close buffer" },
    },
    opts = {
      options = {
        always_show_bufferline = false,
        -- No mouse-oriented close icons -- <leader>bd covers it, and this
        -- is a keyboard-first writing tool, not an IDE tab bar.
        show_buffer_close_icons = false,
        show_close_icon = false,
        -- No LSP/diagnostics setup in this bundle; would just be dead chrome.
        diagnostics = false,
      },
    },
  },
}
