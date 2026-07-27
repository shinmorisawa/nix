{ config, pkgs, ... }:

{
    imports = [
        ./packages.nix 
        ./ghostty.nix
        ./waybar.nix
        ./rofi.nix
        ./mpd.nix
        ./themes.nix
        ./mpv.nix
        ./mango.nix
        ./shell.nix
        ./programs.nix
        ./services.nix
    ];

    programs.home-manager.enable = true;
}
