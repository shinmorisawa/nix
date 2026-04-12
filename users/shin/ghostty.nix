{ pkgs, ... }:

{
    programs.ghostty = {
        enable = true;
        package = pkgs.ghostty;

        enableFishIntegration = true;

        settings = {
            background = "000000";
            foreground = "ffffff";
            font-size = "11.25";
            theme = "tokyodark";
            background-opacity = "0.5";
        };
    };

    xdg.configFile."ghostty/themes/tokyodark".source = ./../../config/ghostty-tokyodark.theme;
}
