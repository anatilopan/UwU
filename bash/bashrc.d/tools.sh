# --- fzf: Ctrl-R fuzzy history, Ctrl-T fuzzy file picker, Alt-C fuzzy cd ---
if command -v fzf &>/dev/null && [[ $- == *i* ]]; then
    eval "$(fzf --bash)"
fi

# --- fd: faster file listing for fzf (Ctrl-T / Alt-C), respects .gitignore ---
if command -v fd &>/dev/null; then
    export FZF_DEFAULT_COMMAND='fd --type f --hidden --exclude .git'
    export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
    export FZF_ALT_C_COMMAND='fd --type d --hidden --exclude .git'
fi

# --- eza: ls with icons and git status; plain ls fallback ---
if command -v eza &>/dev/null; then
    alias ls='eza --group-directories-first'
    alias ll='eza -lah --group-directories-first --git --icons'
    alias lt='eza --tree --level=2 --icons'
else
    alias ll='ls -lah'
fi
