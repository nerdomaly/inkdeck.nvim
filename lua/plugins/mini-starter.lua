-- Start screen shown instead of an empty buffer when nvim is launched
-- with no file argument. mini.starter's own `autoopen` logic (on by
-- default) decides whether to actually show it, so this is lazy-loaded
-- on VimEnter rather than cmd/keys like most other plugins here.

local header = table.concat({
  "█████  █   █  █   █  ████   █████  █████  █   █",
  "  █    ██  █  █  █   █   █  █      █      █  █  ",
  "  █    █ █ █  ███    █   █  ████   █      ███   ",
  "  █    █  ██  █  █   █   █  █      █      █  █  ",
  "█████  █   █  █   █  ████   █████  █████  █   █",
  "",
  "a distraction-free writer's deck",
}, "\n")

return {
  {
    "nvim-mini/mini.starter",
    event = "VimEnter",
    opts = {
      header = header,
      items = {
        { name = "Find chapter", action = "Telescope find_files", section = "Manuscript" },
        { name = "Grep manuscript", action = "Telescope live_grep", section = "Manuscript" },
        { name = "Recent files", action = "Telescope oldfiles", section = "Manuscript" },
        { name = "Browse files", action = "Oil", section = "Manuscript" },
        { name = "Quit", action = "qa", section = "Manuscript" },
      },
    },
    config = function(_, opts)
      require("mini.starter").setup(opts)
      -- Word count in the statusline is meaningless for the dashboard's
      -- own text and cuts against the distraction-free point of this
      -- screen, so blank it out. mini.starter sets its buffer's filetype
      -- with `noautocmd`, so a plain FileType autocmd never fires here;
      -- MiniStarterOpened is its documented hook for this instead.
      vim.api.nvim_create_autocmd("User", {
        pattern = "MiniStarterOpened",
        callback = function()
          vim.opt_local.statusline = " "
        end,
      })
    end,
  },
}
