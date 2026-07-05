#!/usr/bin/env bash

# using the full block for that "led" or "bitmap" look
char="█"

config_file="/tmp/bar_cava_config"
cat >"$config_file" <<EOF
[general]
framerate = 165
bars = 50
[input]
method = pipewire
source = auto
[output]
method = raw
raw_target = /dev/stdout
data_format = ascii
ascii_max_range = 65535 
channels = mono
mono_option = average
[smoothing]
noise_reduction = 20
EOF

cava -p "$config_file" | awk -v char="$char" '
# unused
BEGIN {
    for (i = 0; i <= 255; i++) {
        r = int(113 + (164 - 113) * (i - 1) / 254)
        g = int(153 + (133 - 153) * (i - 1) / 254)
        b = int(238 + (221 - 238) * (i - 1) / 254)
        colors[i] = sprintf("#%02X%02X%02X", r, g, b)
    }
}

{
    gsub(/\r/, "")
    n = split($0, a, ";")
    out = ""
    for (i = 1; i <= n; i++) {
        if (a[i] ~ /^[0-9]+$/) {
            v = a[i] + 0
            if (v > 65535) v = 65535
            
            # wrap each bar in a span with its grayscale color
            out = out "<span foreground=\"#7199EE\" alpha=\"" v "\" >" char "</span>"
        }
    }
    # wrap the whole thing to prevent waybar from freaking out over 300 spans
    # use a tiny font size if it overflows your bar
    print "<span>" out "</span>"
    fflush()
}
'
