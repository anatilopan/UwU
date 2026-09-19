# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Added

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

- `bashrc`: pyenv and cargo only initialised when installed, oh-my-posh config path uses `$HOME`, so the config loads on machines without them;
- `bashrc.d/functions.sh`: `reload` moved here from `aliases.sh`

### Removed

- `bashrc.d/aliases.sh`: duplicate clipboard aliases `cs` and `vs`
