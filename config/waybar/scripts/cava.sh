#!/usr/bin/env bash

bar=" .-':_,^=;><+!rc*z?sLTv)J7(|Fi{C}fI31tlu[neoZ5Yxjya]2ESwqkP6h9d4VpOGbUAKXHm8RD#Bg0MNWQ%&@"

config_file="/tmp/bar_cava_config"
cat >"$config_file" <<EOF
[general]
framerate = 165
bars = 30
[input]
method = pipewire
source = auto
[output]
method = raw
raw_target = /dev/stdout
data_format = ascii
ascii_max_range = 88
channels = mono
mono_option = average
[smoothing]
noise_reduction = 20
EOF

cava -p "$config_file" | awk -v bar="$bar" '
{
    gsub(/\r/, "")
    n = split($0, a, ";")
    out = ""
    for (i = 1; i <= n; i++) {
        if (a[i] ~ /^[0-9]+$/) {
            c = substr(bar, a[i]+1, 1)
            if (c == "&") c = "&amp;"
            else if (c == "<") c = "&lt;"
            else if (c == ">") c = "&gt;"
            out = out c
        }
    }
    printf "%s\n", out
    fflush()
}
'
