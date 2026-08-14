-- Anchor Neovim's cwd to the nearest git root on startup, so Telescope
-- and Oil operate on the whole document repo even when launched from
-- inside a piece's subfolder (e.g. `nvim` from stories/some-piece/).
vim.api.nvim_create_autocmd("VimEnter", {
  callback = function()
    local root = vim.fs.root(0, ".git")
    if root then
      vim.cmd.cd(root)
    end
  end,
})
