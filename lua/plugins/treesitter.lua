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
          -- Fold by heading so scene breaks can collapse without
          -- splitting into separate files. foldlevel = 99 keeps
          -- everything open on entry; za/zc to fold a scene manually.
          vim.wo.foldmethod = "expr"
          vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"
          vim.wo.foldlevel = 99
        end,
      })
    end,
  },
}
