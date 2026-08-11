-- Options tuned for prose, not code.

local opt = vim.opt

-- Soft-wrap at word boundaries instead of hard-wrapping mid-word.
opt.wrap = true
opt.linebreak = true
opt.breakindent = true

-- Move by visual (wrapped) line, not by file line, which matches how
-- prose is actually read on screen.
vim.keymap.set({ "n", "x" }, "j", "gj", { silent = true })
vim.keymap.set({ "n", "x" }, "k", "gk", { silent = true })

-- Spellcheck on by default; add words with zg, ignore-for-session with zG.
opt.spell = true
opt.spelllang = { "en_us" }

-- Conceal markdown syntax markers (e.g. **bold**) so prose reads cleanly.
opt.conceallevel = 2
opt.concealcursor = "nc"

-- No line numbers or sign column clutter for a distraction-free canvas.
opt.number = false
opt.relativenumber = false
opt.signcolumn = "no"
opt.cursorline = false
opt.laststatus = 2
opt.foldcolumn = "0"

-- Prose files rarely need tabs-as-code; keep indentation simple.
opt.expandtab = true
opt.shiftwidth = 2
opt.tabstop = 2

opt.scrolloff = 8
opt.undofile = true
opt.swapfile = false
