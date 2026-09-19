# --- History ---
# Keep a long history, skip duplicates and space-prefixed commands, add timestamps
HISTSIZE=100000
HISTFILESIZE=200000
HISTCONTROL=ignoreboth:erasedups
HISTTIMEFORMAT='%F %T  '
shopt -s histappend

# Up/Down arrows search history for commands starting with what's already typed
if [[ $- == *i* ]]; then
    bind '"\e[A": history-search-backward'
    bind '"\e[B": history-search-forward'
fi
