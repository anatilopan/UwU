# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Added

- `nvim-keymaps/`: searchable HTML reference of every Neovim mapping (mine, plugins, defaults) in the maw style; `generate.lua` collects them from the live config into `keymaps.js`; maw fonts with their OFL licences;
- `install.sh`: links all configs into the home directory (backing up what is in the way), creates a local `aliases.sh`, lists missing tools with the `dnf install` command;
- `bash/inputrc`: case-insensitive Tab completion, `-`/`_` treated alike, matches listed on the first Tab, coloured matches;
- `git/gitconfig`: global git config with `push.autoSetupRemote`, `pull.rebase`, `rebase.autoStash`, `fetch.prune`, `rerere`, `diff.colorMoved`, `st` and `lg` aliases, and an include for `~/.gitconfig.local`;
- `bashrc.d/tools.sh`: fd as the fzf file/dir source, eza as `ls`, `ll`, `lt` (plain `ls -lah` fallback for `ll`);
- `install.sh`: Neovim links (`neovim_init.lua`, `neovim_lua/` -> `~/.config/nvim`);
- `bashrc`: startup warning listing missing tools (pyenv, oh-my-posh, zoxide, fzf, bat, cargo) and a missing `aliases.sh`;
- `bash/bashrc` and `bash/bashrc.d/`: Bash configuration, symlinked to `~/.bashrc` and `~/.bashrc.d`;
- `bashrc`: zoxide initialised after the prompt so its hook is not overwritten;
- `bashrc.d/functions.sh`: `beep` (count and delay in any order), `mkcd`, `extract`;
- `bashrc.d/history.sh`: 100k/200k history size, deduplication, timestamps, Up/Down prefix search;
- `bashrc.d/options.sh`: `autocd`, `cdspell`, `globstar`;
- `bashrc.d/tools.sh`: fzf key bindings;
- `bashrc.d/aliases.sh`: `ll`, `..`, `...`, `cat` -> `bat`;
- `README.md`: Bash section with setup instructions;
- `changelog.md`;
- `.gitignore`: `bash/bashrc.d/aliases.sh` kept out of the repo (personal paths)

### Changed

- `neovim_lua/plugins/lsp-config.lua`, `telescope.lua`, `neo-tree.lua`: `desc` on every mapping;
- `neovim_lua/plugins/treesitter.lua`: moved to the nvim-treesitter `main` branch API (the `nvim-treesitter.configs` module no longer exists); highlighting and indentation enabled per buffer, missing parsers installed on demand; `bash` and `json` parsers added;
- `neovim_lua/plugins/lsp-config.lua`: `require("lspconfig").x.setup()` replaced by `vim.lsp.config("*")` with mason-lspconfig enabling installed servers; `vim.diagnostic.goto_prev/next` replaced by `vim.diagnostic.jump`;
- `neovim_lua/plugins/telescope.lua`: `0.1.5` -> `^0.2.0` (older versions call removed nvim-treesitter modules);
- `neovim_init.lua`: `vim.loop` -> `vim.uv`;
- `install.sh`: checks for `tree-sitter` and `gcc`;
- `README.md`: Nvim requirements and one-line `dnf install`;
- `ll`: moved from `aliases.sh` (untracked) to `tools.sh` so it exists on every machine;
- `bashrc`: missing-tools warning points to `install.sh`;
- `README.md`: Setup section with the link table, Git section;
- `joe_omp.json`: migrated to oh-my-posh config format version 3 (key order, `cache_duration` per segment); prompt unchanged;
- `bashrc`: pyenv and cargo only initialised when installed, oh-my-posh config path uses `$HOME`, so the config loads on machines without them;
- `bashrc.d/functions.sh`: `reload` moved here from `aliases.sh`

### Removed

- `neovim_lua/plugins/lsp-config.lua`: `gr` (references), which delayed Neovim's built-in `grr`/`grn`/`gra`/`gri`/`grt`; use `grr` instead;
- `bashrc.d/aliases.sh`: duplicate clipboard aliases `cs` and `vs`
