-- Writing-oriented keymaps.

local map = vim.keymap.set

map("n", "<leader>w", "<cmd>w<cr>", { desc = "Save" })

-- Toggle spellcheck on the fly.
map("n", "<leader>ts", function()
  vim.opt.spell = not vim.opt.spell:get()
end, { desc = "Toggle spellcheck" })

-- Jump to next/previous misspelled word.
map("n", "]s", "]s", { desc = "Next misspelling" })
map("n", "[s", "[s", { desc = "Previous misspelling" })
