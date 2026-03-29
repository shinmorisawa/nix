{ pkgs, ... }:

{
    home.packages = with pkgs; [
        chromium
        vesktop
        thunderbird
        mpv
        ffmpeg
        obs-studio
        inkscape
        gimp
        audacity
        prismlauncher
        dolphin-emu
        stockfish
        steam
        cmatrix
        pipes
        asciiquarium
        cbonsai
        nyancat
        lolcat
        cowsay
        fortune
        sl
        waybar
    ];
}
