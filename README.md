# Customization of different apps and envs

## OhMyPosh

joe_omp.json -> version 0.8

## Nvim

`neovim_init.lua` + `neovim_lua/` (lazy.nvim). Needs Neovim 0.12+, `tree-sitter-cli` and a C
compiler for the treesitter parsers. Language servers (lua_ls, pyright, marksman, jsonls) come
from Mason: `:MasonInstall lua-language-server pyright marksman json-lsp stylua`.

### Keymap reference

`nvim-keymaps/index.html` lists every mapping (mine, plugins, Neovim defaults) with a search
bar, styled like [maw](https://joe.aphios.ro). Plain HTML + vanilla JS, no dependencies,
works from `file://`. After changing mappings, regenerate the data and open it:

```bash
nvim --headless -c "luafile nvim-keymaps/generate.lua" && xdg-open nvim-keymaps/index.html
```

`generate.lua` starts Neovim with this config, opens a Python file (LSP), Neo-tree and
Telescope to capture their buffer mappings, and writes `keymaps.js`.
Fonts: Andada Pro, Source Sans 3, Source Code Pro (SIL OFL, licences in `nvim-keymaps/fonts/`).



## Setup

```bash
./install.sh
```

Links everything below into the home directory (existing files are moved to
`<name>.bak.<timestamp>`), creates an empty local `aliases.sh` if missing, and
lists missing tools with the `dnf install` command for them. Safe to re-run.

| Repo | Linked to |
|---|---|
| `bash/bashrc` | `~/.bashrc` |
| `bash/bashrc.d/` | `~/.bashrc.d` |
| `bash/inputrc` | `~/.inputrc` |
| `git/gitconfig` | `~/.gitconfig` |
| `neovim_init.lua` | `~/.config/nvim/init.lua` |
| `neovim_lua/` | `~/.config/nvim/lua` |

Tools: `oh-my-posh`, `fzf`, `zoxide`, `bat`, `eza`, `fd-find`, `tealdeer`, `neovim`, `tree-sitter-cli`, `gcc`, `pyenv`, cargo

```bash
sudo dnf install fzf zoxide bat eza fd-find tealdeer neovim tree-sitter-cli gcc && tldr --update
```

## Bash

- `aliases.sh`: clipboard, project shortcuts, `..`, `cat` -> bat. Not tracked: it holds personal paths, so create it locally
- `functions.sh`: `beep`, `reload`, `mkcd`, `extract`
- `history.sh`: large deduplicated history, Up/Down prefix search
- `options.sh`: `autocd`, `cdspell`, `globstar`
- `tools.sh`: fzf key bindings (using fd when installed), eza as `ls`/`ll`/`lt` with a plain `ls` fallback. zoxide is initialised at the end of `bashrc`, after the prompt
- `inputrc`: case-insensitive Tab completion, matches listed on the first Tab, coloured

## Git

`git/gitconfig`: identity, `push.autoSetupRemote`, `pull.rebase`, `rebase.autoStash`,
`fetch.prune`, `rerere`, `diff.colorMoved`, aliases `git st` and `git lg`.
Machine-specific settings go in `~/.gitconfig.local` (included, not tracked).
