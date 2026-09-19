# --- fzf: Ctrl-R fuzzy history, Ctrl-T fuzzy file picker, Alt-C fuzzy cd ---
if command -v fzf &>/dev/null && [[ $- == *i* ]]; then
    eval "$(fzf --bash)"
fi
