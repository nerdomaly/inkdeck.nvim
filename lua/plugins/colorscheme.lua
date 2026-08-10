-- Starter plugin: proves the lazy.nvim bootstrap works end-to-end.
-- Swap this out (or add more files here) during plugin curation.

return {
  {
    "rose-pine/neovim",
    name = "rose-pine",
    lazy = false,
    priority = 1000,
    config = function()
      vim.cmd("colorscheme rose-pine")
    end,
  },
}
