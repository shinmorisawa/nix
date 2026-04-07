#!/usr/bin/env bash

pkill waybar
waybar &
disown $(pidof waybar)
