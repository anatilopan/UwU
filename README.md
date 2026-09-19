# Customization of different apps and envs

## OhMyPosh

joe_omp.json -> version 0.8

## Nvim

New Nvim config



## Bash

`bash/bashrc` and `bash/bashrc.d/` are symlinked into the home directory:

```bash
ln -s ~/Documents/Personal/Projects/UwU/bash/bashrc   ~/.bashrc
ln -s ~/Documents/Personal/Projects/UwU/bash/bashrc.d ~/.bashrc.d
```

- `aliases.sh`: clipboard, project shortcuts, general aliases (`ll`, `..`, `cat` -> bat). Not tracked: it holds personal paths, so create it locally
- `functions.sh`: `beep`, `reload`, `mkcd`, `extract`
- `history.sh`: large deduplicated history, Up/Down prefix search
- `options.sh`: `autocd`, `cdspell`, `globstar`
- `tools.sh`: fzf key bindings (zoxide is initialised at the end of `bashrc`, after the prompt)

Requires: `fzf`, `zoxide`, `bat`, `oh-my-posh`
