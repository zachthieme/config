#!/usr/bin/env bash
set -euo pipefail

cat /home/zach/.config/nixpkgs/xmonad/xmonad_keys |
    yad --title=yad --text-info --back=#282c34 --fore=#46d9ff --geometry=1200x800

