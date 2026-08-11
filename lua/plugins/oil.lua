-- On-demand directory editing (edit the file listing as a buffer, `-` to
-- open the parent directory) instead of a persistent sidebar tree, to
-- match the no-clutter writing setup.

return {
  {
    "stevearc/oil.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    -- Oil's own documented setup step, so directory buffers open in oil
    -- instead of netrw. Must run before oil loads, hence init not config.
    init = function()
      vim.g.loaded_netrw = 1
      vim.g.loaded_netrwPlugin = 1
    end,
    cmd = "Oil",
    keys = {
      { "-", "<cmd>Oil<cr>", desc = "Open parent directory" },
    },
    opts = {
      view_options = {
        show_hidden = true,
      },
    },
  },
}
