-- Save on insert-leave / text-changed idle so you never have to think
-- about :w mid-flow. okuuva's fork is the maintained one; Pocco81's
-- original has been stale for years.

return {
  {
    "okuuva/auto-save.nvim",
    event = { "InsertLeave", "TextChanged" },
    opts = {},
  },
}
