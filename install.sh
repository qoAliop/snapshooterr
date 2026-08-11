#!/usr/bin/env bash

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BIN_DIR="$HOME/.local/bin"
FISH_CONFIG="$HOME/.config/fish/config.fish"

mkdir -p "$BIN_DIR"
mkdir -p "$(dirname "$FISH_CONFIG")"

if [[ ! -f "$SCRIPT_DIR/snapshooterr" ]]; then
    echo "Error: snapshooterr not found."
    exit 1
fi

if [[ ! -f "$SCRIPT_DIR/snapshooterr-session" ]]; then
    echo "Error: snapshooterr-session not found."
    exit 1
fi

cp "$SCRIPT_DIR/snapshooterr" "$BIN_DIR/snapshooterr"
cp "$SCRIPT_DIR/snapshooterr-session" "$BIN_DIR/snapshooterr-session"

chmod +x "$BIN_DIR/snapshooterr"
chmod +x "$BIN_DIR/snapshooterr-session"

if ! grep -Fq "# Snapshooterr automatic terminal session" "$FISH_CONFIG" 2>/dev/null; then
    cat >> "$FISH_CONFIG" <<'EOF'

# Snapshooterr automatic terminal session

if not set -q SNAPSHOOTERR_SESSION_ID
    if not set -q SNAPSHOOTERR_STARTED
        set -gx SNAPSHOOTERR_STARTED 1
        ~/.local/bin/snapshooterr-session
        exit
    end
end
EOF
fi

echo "Snapshooterr installed successfully."
echo
echo "Installed:"
echo "  $BIN_DIR/snapshooterr"
echo "  $BIN_DIR/snapshooterr-session"
echo
echo "Fish configuration updated:"
echo "  $FISH_CONFIG"
echo
echo "Restart your terminal to start Snapshooterr automatically."
