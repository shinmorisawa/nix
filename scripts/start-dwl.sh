#!/bin/bash

export XDG_CURRENT_DESKTOP=wlroots
export XDG_SESSION_TYPE=wayland
export XDG_SESSION_DESKTOP=wlroots
export WLR_NO_HARDWARE_CURSORS=1
export XCURSOR_PATH="$HOME/.local/share/icons:$XCURSOR_PATH"
export XCURSOR_THEME=Drop-WhiteRinal
export XCURSOR_SIZE=32
export WLR_DEBUG=1

exec /home/shin/clone/dwl/dwl -d 2>&1 | tee /tmp/dwl.log
