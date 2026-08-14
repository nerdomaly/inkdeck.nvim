-- Fuzzy-find and grep across documents. Plain Lua sorter only (no
-- fzf-native build step) to keep this bundle easy to clone and install.

return {
  {
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    cmd = "Telescope",
    keys = {
      { "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find document" },
      { "<leader>fg", "<cmd>Telescope live_grep<cr>", desc = "Grep documents" },
      { "<leader>fr", "<cmd>Telescope oldfiles<cr>", desc = "Recent files" },
    },
    opts = {
      defaults = {
        -- Keep results scoped to actual writing, not repo scaffolding
        -- (tooling scripts, README/CLAUDE docs, the generated index).
        file_ignore_patterns = { "^scripts/", "^README%.md$", "^CLAUDE%.md$", "^INDEX%.md$" },
      },
    },
  },
}
