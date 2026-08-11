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
    -- VimEnter as well as cmd/keys: loading only needs to be lazy for the
    -- on-demand triggers, but we need this to run at startup regardless,
    -- to decide whether to land in the file browser.
    event = "VimEnter",
    cmd = "Oil",
    keys = {
      { "-", "<cmd>Oil<cr>", desc = "Open parent directory" },
    },
    opts = {
      view_options = {
        show_hidden = true,
      },
    },
    config = function(_, opts)
      require("oil").setup(opts)
      -- Land in the file browser instead of an empty buffer when nvim
      -- is launched with no file argument.
      if vim.fn.argc() == 0 then
        require("oil").open()
      end
    end,
  },
}
