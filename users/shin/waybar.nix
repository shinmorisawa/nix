{ pkgs, ... }:

{
    programs.eww = {
        enable = true;
    };

    xdg.configFile."eww".source = ./../../config/eww;
}
