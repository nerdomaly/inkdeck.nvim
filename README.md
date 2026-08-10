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
- `lua/plugins/*.lua` — one file per plugin (or plugin group); every file
  in this directory is auto-loaded by lazy.nvim.
- `lazy-lock.json` — pinned plugin versions, committed for reproducibility.

## Adding a plugin

Drop a new file in `lua/plugins/` returning a lazy.nvim plugin spec table.
No other wiring is needed — lazy.nvim imports the whole directory.

## License

MIT — see [LICENSE](LICENSE).
