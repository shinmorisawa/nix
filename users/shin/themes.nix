{ pkgs, ... }:

{
    xdg.dataFile."icons/Drop-WhiteRinal".source = ./../../assets/Drop-WhiteRinal;
    home.file.".themes/Reversal-Dark".source = ./../../assets/Reversal-Dark;

    gtk = {
        enable = true;

        font = {
            name = "JetBrains Mono Nerd Font";
            size = 11;
        };

        theme = {
            name = "Reversal-Dark";
        };

        iconTheme = {
            name = "Reversal-Dark";
        };

        cursorTheme = {
            name = "Breeze_Black";
            size = 24;
        };

        gtk3.extraConfig = {
            gtk-application-prefer-dark-theme = 1;
            gtk-im-module = "fcitx";
            gtk-toolbar-style = "GTK_TOOLBAR_ICONS";
            gtk-toolbar-icon-size = "GTK_ICON_SIZE_LARGE_TOOLBAR";
            gtk-button-images = 0;
            gtk-menu-images = 0;
        };

        gtk4.extraConfig = {
            gtk-application-prefer-dark-theme = 1;
            gtk-im-module = "fcitx";
        };
    };

    xdg.configFile."gtk-4.0/assets".source = ./../../assets/Reversal-Dark/gtk-4.0/assets;
    xdg.configFile."gtk-4.0/gtk.css".source = ./../../assets/Reversal-Dark/gtk-4.0/gtk.css;
}
