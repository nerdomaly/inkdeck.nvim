# inkdeck.nvim

A Neovim configuration bundle for creative writing — not programming.
Built for a distraction-free "writer's deck" setup: soft-wrapped prose,
spellcheck on by default, concealed markdown syntax, and no code-editor
clutter (line numbers, sign column, etc.).

Plugins are managed by [lazy.nvim](https://github.com/folke/lazy.nvim).

## Requirements

- Neovim >= 0.9
- git

## Install

```sh
git clone https://github.com/<your-username>/inkdeck.nvim.git ~/inkdeck.nvim
~/inkdeck.nvim/install.sh
nvim
```

`install.sh` symlinks this repo to `~/.config/nvim`. If you already have a
Neovim config there, it's backed up to `~/.config/nvim.bak-<timestamp>`
first — nothing is deleted.

On first launch, lazy.nvim bootstraps itself and installs the configured
plugins automatically.

## Structure

- `init.lua` — entry point; bootstraps lazy.nvim and loads config/plugins.
- `lua/config/options.lua` — editor options tuned for prose.
- `lua/config/keymaps.lua` — writing-oriented keymaps.
- `lua/config/statusline.lua` — statusline: live word count + battery.
- `lua/plugins/*.lua` — one file per plugin (or plugin group); every file
  in this directory is auto-loaded by lazy.nvim.
- `lazy-lock.json` — pinned plugin versions, committed for reproducibility.

## Organizing a manuscript

inkdeck.nvim doesn't scaffold a manuscript for you, but the bundle is built
around a simple layout: one markdown file per chapter, in a flat
directory, numbered so they sort in reading order.

```
manuscript/
  01-arrival.md
  02-the-storm.md
  03-the-return.md
```

Scene breaks within a chapter are just `##` headings — treesitter-based
folding lets you collapse a scene (`za`) without splitting it into its own
file. See Keymaps below for how to move around that layout without a
sidebar tree.

Launching `nvim` with no file argument shows a start screen (mini.starter)
instead of an empty buffer, with shortcuts to find a chapter, grep the
manuscript, reopen a recent file, browse the directory (oil), or quit.

## Keymaps

Leader is `<space>`. Press `<leader>` and pause to see a popup of all
available chords (which-key.nvim).

| Keymap | Action |
| --- | --- |
| `<leader>w` | Save |
| `<leader>ts` | Toggle spellcheck |
| `]s` / `[s` | Next / previous misspelling |
| `<leader>zz` | Toggle zen mode |
| `<leader>mp` | Toggle markdown preview |
| `<leader>ff` | Find chapter file (telescope) |
| `<leader>fg` | Grep manuscript (telescope) |
| `<leader>fr` | Recent files (telescope) |
| `-` | Open parent directory (oil) |

## Adding a plugin

Drop a new file in `lua/plugins/` returning a lazy.nvim plugin spec table.
No other wiring is needed — lazy.nvim imports the whole directory.

## License

MIT — see [LICENSE](LICENSE).
