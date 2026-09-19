#!/usr/bin/env bash
# Link the UwU configs into the home directory and report missing tools.
# Safe to re-run: correct links are left alone, anything else in the way
# is moved to <name>.bak.<timestamp> first.
set -euo pipefail

repo="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
stamp="$(date +%Y%m%d-%H%M%S)"

# source (in repo)          target (in home)
links=(
    "bash/bashrc"           "$HOME/.bashrc"
    "bash/bashrc.d"         "$HOME/.bashrc.d"
    "bash/inputrc"          "$HOME/.inputrc"
    "git/gitconfig"         "$HOME/.gitconfig"
    "neovim_init.lua"       "$HOME/.config/nvim/init.lua"
    "neovim_lua"            "$HOME/.config/nvim/lua"
)

link() {
    local src="$repo/$1" dest="$2"
    if [[ "$(readlink "$dest" 2>/dev/null)" == "$src" ]]; then
        echo "  ok      $dest"
        return
    fi
    if [[ -e "$dest" || -L "$dest" ]]; then
        mv "$dest" "$dest.bak.$stamp"
        echo "  backup  $dest -> $dest.bak.$stamp"
    fi
    mkdir -p "$(dirname "$dest")"
    ln -s "$src" "$dest"
    echo "  linked  $dest -> $src"
}

echo "Links:"
for ((i = 0; i < ${#links[@]}; i += 2)); do
    link "${links[i]}" "${links[i+1]}"
done

# aliases.sh holds personal paths and is gitignored, so start one if missing
aliases="$repo/bash/bashrc.d/aliases.sh"
if [[ ! -f "$aliases" ]]; then
    printf '# Personal aliases (not tracked by git)\n' > "$aliases"
    echo "  created $aliases (empty, gitignored)"
fi

echo
echo "Tools:"
# command   package
tools=(
    oh-my-posh ""
    fzf        fzf
    zoxide     zoxide
    bat        bat
    eza        eza
    fd         fd-find
    tldr       tealdeer
    nvim       neovim
    tree-sitter tree-sitter-cli
    gcc        gcc
    pyenv      ""
)
missing_pkgs=()
for ((i = 0; i < ${#tools[@]}; i += 2)); do
    cmd="${tools[i]}" pkg="${tools[i+1]}"
    if command -v "$cmd" &>/dev/null || [[ $cmd == pyenv && -x "$HOME/.pyenv/bin/pyenv" ]]; then
        echo "  ok      $cmd"
    else
        echo "  missing $cmd"
        [[ -n $pkg ]] && missing_pkgs+=("$pkg")
    fi
done
[[ -f "$HOME/.cargo/env" ]] && echo "  ok      cargo" || echo "  missing cargo (https://rustup.rs)"

if (( ${#missing_pkgs[@]} )); then
    echo
    echo "Install with:  sudo dnf install ${missing_pkgs[*]}"
fi
echo
echo "Open a new terminal (or run: reload) to use the new config."
