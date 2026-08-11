-- Treesitter, scoped to just the markdown parsers render-markdown.nvim needs.
-- Not a general IDE setup — see CLAUDE.md on keeping programming support minimal.

return {
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter").install({ "markdown", "markdown_inline" })
      vim.api.nvim_create_autocmd("FileType", {
        pattern = "markdown",
        callback = function()
          vim.treesitter.start()
        end,
      })
    end,
  },
}
