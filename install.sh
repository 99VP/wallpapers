#!/usr/bin/env bash
# Install `wallpaper` into ~/.local/bin and print Hyprland setup hints.
set -eu
here="$(cd "$(dirname "$0")" && pwd)"
bin="${XDG_BIN_HOME:-$HOME/.local/bin}"
mkdir -p "$bin"
install -m755 "$here/wallpaper" "$bin/wallpaper"
printf '\342\234\224 installed: %s/wallpaper\n' "$bin"

case ":$PATH:" in
    *":$bin:"*) ;;
    *) printf '\342\232\240 %s is not in $PATH — add it to your shell profile\n' "$bin" ;;
esac

cat <<'EOF'

Hyprland (~/.config/hypr/hyprland.conf):
  exec-once = wallpaper restore            # re-apply the last wallpaper at login
  bind = SUPER, W, exec, wallpaper pick    # pick a wallpaper
  bind = SUPER SHIFT, W, exec, wallpaper random

Backend: install one of hyprpaper, swww/awww, swaybg or feh.
Optional: fuzzel/rofi/wofi (picker), imagemagick (brightness sort).
EOF
