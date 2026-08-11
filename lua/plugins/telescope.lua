-- Fuzzy-find and grep across chapter files. Plain Lua sorter only (no
-- fzf-native build step) to keep this bundle easy to clone and install.

return {
  {
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    cmd = "Telescope",
    keys = {
      { "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find chapter file" },
      { "<leader>fg", "<cmd>Telescope live_grep<cr>", desc = "Grep manuscript" },
      { "<leader>fr", "<cmd>Telescope oldfiles<cr>", desc = "Recent files" },
    },
    opts = {},
  },
}
