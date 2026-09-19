# Ring the terminal bell. Args in any order: a whole number is the count
# (default 3), a number with a dot is the delay in seconds (default 0.12).
# e.g. beep | beep 5 | beep .3 | beep 5 .3 | beep 1.0
beep() {
    local count=3 delay=0.12 arg i
    for arg in "$@"; do
        case $arg in
            *.*) delay=$arg ;;
            *)   count=$arg ;;
        esac
    done
    for ((i=0; i<count; i++)); do printf '\a'; sleep "$delay"; done
}

# Reload the shell config and print a short summary
reload() {
    source ~/.bashrc
    echo "----------------------------------------"
    echo "✅ Bash configuration reloaded."
    echo "Python: $(python --version)"
    echo "User:   $(whoami)"
    echo "Date:   $(date '+%Y-%m-%d %H:%M:%S')"
    echo "----------------------------------------"
}

# Make a directory (with parents) and cd into it
mkcd() { mkdir -p -- "$1" && cd -- "$1"; }

# Unpack an archive based on its extension
extract() {
    [[ -f $1 ]] || { echo "extract: '$1' is not a file" >&2; return 1; }
    case $1 in
        *.tar.gz|*.tgz)   tar xzf "$1" ;;
        *.tar.xz|*.txz)   tar xJf "$1" ;;
        *.tar.bz2|*.tbz2) tar xjf "$1" ;;
        *.tar.zst)        tar --zstd -xf "$1" ;;
        *.tar)            tar xf "$1" ;;
        *.gz)             gunzip -k "$1" ;;
        *.xz)             unxz -k "$1" ;;
        *.bz2)            bunzip2 -k "$1" ;;
        *.zip)            unzip "$1" ;;
        *.7z)             7z x "$1" ;;
        *.rar)            unrar x "$1" ;;
        *) echo "extract: don't know how to extract '$1'" >&2; return 1 ;;
    esac
}
