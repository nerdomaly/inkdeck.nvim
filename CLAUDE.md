# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What this is

inkdeck.nvim is a Neovim configuration bundle for **creative writing, not programming**. It targets a distraction-free "writer's deck" setup: soft-wrapped prose, spellcheck on by default, concealed markdown syntax, no code-editor clutter (line numbers, sign column, etc.). It is meant to be cloned and installed by other people too, so changes should stay generic (no machine-specific paths or personal settings baked in beyond what's in this repo).

Any programming/LSP support that gets added should stay minimal — just enough to edit this bundle's own Lua config and shell scripts (`lua_ls`, a bash language server), not a general IDE setup. Full-blown coding features are out of scope.

## Commands

- **Apply/reload after editing config**: relaunch `nvim`, or from inside `nvim` run `:Lazy sync` to pick up plugin spec changes.
- **Headless plugin sync (verify no errors without opening the UI)**:
  ```sh
  nvim --headless "+Lazy! sync" +qa
  ```
- **Check plugin/health status**:
  ```sh
  nvim --headless -c "checkhealth lazy" -c "qa"
  ```
- **Install/reinstall as your live config** (symlinks this repo to `~/.config/nvim`, backing up any existing config first):
  ```sh
  ./install.sh
  ```
- There is no separate lint/test/build step — "does it load and sync cleanly" (above) is the correctness check for this project.

## Architecture

- `init.lua` — entry point. Sets `vim.g.mapleader = " "` (must happen before any `<leader>` keymaps are defined), bootstraps lazy.nvim by cloning it into `stdpath('data')/lazy/lazy.nvim` if missing, then loads `config.options`, `config.keymaps`, `config.statusline`, and calls `require("lazy").setup(...)` with `spec = { { import = "plugins" } }`.
- `lua/config/options.lua` — all editor options tuned for prose (wrap/linebreak, spell, conceallevel, disabled number/signcolumn/foldcolumn, etc.). This is the place for any new global editor behavior, not scattered `vim.opt` calls elsewhere.
- `lua/config/keymaps.lua` — writing-oriented keymaps.
- `lua/config/statusline.lua` — sets `vim.opt.statusline` directly (no statusline plugin). Live word count plus a battery percentage that changes icon/color at low levels, since zen mode hides the OS battery indicator behind a full-screen buffer.
- `lua/plugins/*.lua` — **one file per plugin or plugin group**, each returning a lazy.nvim plugin spec table (or list of tables). lazy.nvim auto-imports every file in this directory via the `{ import = "plugins" }` spec in `init.lua` — adding a new plugin means adding a new file here, nothing else needs to be wired up.
- `lazy-lock.json` — pinned plugin commit hashes, intentionally committed (not gitignored) for reproducible installs across machines.
- `install.sh` — idempotent installer: if `~/.config/nvim` already exists and isn't already this repo, it's moved to a timestamped backup (`~/.config/nvim.bak-<timestamp>`) before symlinking this repo into place. Never deletes an existing config.

## Current state

First batch of creative-writing plugins is in, one file per plugin/group under `lua/plugins/`:

- `colorscheme.lua` — rose-pine, the original bootstrap-proving plugin.
- `zen-mode.lua` — folke/zen-mode.nvim + folke/twilight.nvim for focus mode (centers the buffer, dims everything but the current paragraph). `<leader>zz` toggles it.
- `wordy.lua` — preservim/vim-wordy for lightweight weak-word/cliche highlighting, no external binary.
- `treesitter.lua` — nvim-treesitter, scoped to just the `markdown`/`markdown_inline` parsers; exists as a dependency for render-markdown.lua, not general IDE support, and also wires up heading-based folding (`foldexpr`) for markdown buffers so scene breaks within a chapter can collapse.
- `markdown-render.lua` — MeanderingProgrammer/render-markdown.nvim for in-buffer concealed rendering.
- `markdown-preview.lua` — iamcco/markdown-preview.nvim for browser-based live preview (`<leader>mp`); needs Node.js on the system.
- `autosave.lua` — okuuva/auto-save.nvim (the maintained fork; the original Pocco81 repo is stale).
- `telescope.lua` — nvim-telescope/telescope.nvim for fuzzy-finding (`<leader>ff`) and grepping (`<leader>fg`) across chapter files; plain Lua sorter, no fzf-native build step.
- `oil.lua` — stevearc/oil.nvim for on-demand directory editing (`-`) instead of a persistent sidebar tree; replaces netrw. Also opens automatically at startup when nvim is launched with no file argument.
- `which-key.lua` — folke/which-key.nvim, shows a popup of available chords and their descriptions when a key sequence (e.g. `<leader>`) is pressed and paused on.

Not yet picked: anything beyond this batch (e.g. goal tracking beyond a plain word count, thesaurus lookups) — revisit if the need comes up.
