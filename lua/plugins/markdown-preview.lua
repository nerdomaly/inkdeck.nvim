-- Browser-based live preview, for a full rendered check alongside the
-- in-buffer conceal from render-markdown.nvim. Needs Node.js on the
-- system for the preview server (installed by the build step below).

return {
  {
    "iamcco/markdown-preview.nvim",
    ft = "markdown",
    build = function(plugin)
      -- ft-gated, so the plugin isn't on rtp yet at build time; without
      -- this the autoload function can't be found (E117).
      vim.opt.rtp:prepend(plugin.dir)
      vim.fn["mkdp#util#install"]()
    end,
    cmd = { "MarkdownPreview", "MarkdownPreviewStop", "MarkdownPreviewToggle" },
    keys = {
      { "<leader>mp", "<cmd>MarkdownPreviewToggle<cr>", desc = "Toggle markdown preview" },
    },
  },
}
