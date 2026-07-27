{ pkgs, ... }:

{
    programs.ghostty = {
        enable = true;
        package = pkgs.ghostty;

        enableFishIntegration = true;

        settings = {
            background = "06080a";
            foreground = "a0a8cd";
            font-size = "11.25";
            theme = "tokyodark";
            background-opacity = "0.5";
        };
    };

    xdg.configFile."ghostty/themes/tokyodark".source = ./../../config/ghostty-tokyodark.theme;
}
