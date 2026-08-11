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

- `init.lua` — entry point. Bootstraps lazy.nvim by cloning it into `stdpath('data')/lazy/lazy.nvim` if missing, then loads `config.options`, `config.keymaps`, and calls `require("lazy").setup(...)` with `spec = { { import = "plugins" } }`.
- `lua/config/options.lua` — all editor options tuned for prose (wrap/linebreak, spell, conceallevel, disabled number/signcolumn, etc.). This is the place for any new global editor behavior, not scattered `vim.opt` calls elsewhere.
- `lua/config/keymaps.lua` — writing-oriented keymaps.
- `lua/plugins/*.lua` — **one file per plugin or plugin group**, each returning a lazy.nvim plugin spec table (or list of tables). lazy.nvim auto-imports every file in this directory via the `{ import = "plugins" }` spec in `init.lua` — adding a new plugin means adding a new file here, nothing else needs to be wired up.
- `lazy-lock.json` — pinned plugin commit hashes, intentionally committed (not gitignored) for reproducible installs across machines.
- `install.sh` — idempotent installer: if `~/.config/nvim` already exists and isn't already this repo, it's moved to a timestamped backup (`~/.config/nvim.bak-<timestamp>`) before symlinking this repo into place. Never deletes an existing config.

## Current state

Only a single starter colorscheme plugin (`lua/plugins/colorscheme.lua`, rose-pine) exists so far, added purely to prove the lazy.nvim bootstrap works end-to-end. The actual set of creative-writing plugins — focus/zen mode, prose linting, word count/goal tracking, markdown rendering — has not been picked yet and is the next work to do in this repo.
