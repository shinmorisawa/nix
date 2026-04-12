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
ascii_max_range = 255
channels = mono
mono_option = average
[smoothing]
noise_reduction = 20
EOF

cava -p "$config_file" | awk -v char="$char" '
BEGIN {
    # pre-calculate hex values 0-100 to save cpu cycles at 165fps
    for (i = 0; i <= 255; i++) {
        # convert 0-100 range to 0-255 scale
        v = i
        # format as #RRGGBB (grayscale means R=G=B)
        if (v == 0) v = 1
        colors[i] = sprintf("#FFFFFF%02x", v)
    }
}

{
    gsub(/\r/, "")
    n = split($0, a, ";")
    out = ""
    for (i = 1; i <= n; i++) {
        if (a[i] ~ /^[0-9]+$/) {
            v = a[i] + 0
            if (v > 255) v = 255
            
            # wrap each bar in a span with its grayscale color
            out = out "<span foreground=\"" colors[v] "\">" char "</span>"
        }
    }
    # wrap the whole thing to prevent waybar from freaking out over 300 spans
    # use a tiny font size if it overflows your bar
    print "<span>" out "</span>"
    fflush()
}
'
