-- In-buffer concealed markdown rendering (headers, bold, lists styled
-- inline as you type). Uses the conceallevel/concealcursor already set
-- in config.options.

return {
  {
    "MeanderingProgrammer/render-markdown.nvim",
    ft = "markdown",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-tree/nvim-web-devicons",
    },
    opts = {},
  },
}
