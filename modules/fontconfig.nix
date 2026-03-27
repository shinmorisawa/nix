{ config, pkgs, ... }:

{
    fonts.packages = with pkgs; [
        noto-fonts-cjk-sans
            noto-fonts
            noto-fonts-color-emoji
            nerd-fonts.jetbrains-mono
            (pkgs.callPackage ./modules/fonts.nix {})
    ];

    fonts.fontconfig = {
        enable = true;

        antialias = true;
        hinting = {
            enable = true;
            style = "slight";
            autohint = false;
        };
        subpixel = {
            rgba = "rgb";
            lcdfilter = "default";
        };

        defaultFonts = {
            sansSerif = [ "SF Pro Text" "Apple Color Emoji" ];
            serif     = [ "SF Compact Text" "Apple Color Emoji" ];
            monospace = [ "JetBrains Mono Nerd Font" "Apple Color Emoji" ];
        };
    };
}
