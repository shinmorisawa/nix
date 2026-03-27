{ config, pkgs, ... }:

{
    imports = [
        ./packages.nix 
        ./ghostty.nix
        ./waybar.nix
        ./rofi.nix
        ./mpd.nix
        ./themes.nix
    ];


    home.username = "shin";
    home.homeDirectory = "/home/shin";
    home.stateVersion = "25.11";

    home.sessionVariables = {
        XDG_CURRENT_DESKTOP = "wlroots";
        XDG_SESSION_TYPE = "wayland";
        XDG_SESSION_DESKTOP = "wlroots";
        WLR_NO_HARDWARE_CURSORS = "1";
        XCURSOR_PATH = "/home/shin/.local/share/icons";
        XCURSOR_THEME = "Drop-WhiteRinal";
        XCURSOR_SIZE = "32";
        WLR_DEBUG = "1";
    };

#home.packages = with pkgs; {
#    prismlauncher
#    discord
#};

    programs.fish = {
        enable = true;
        shellAliases = {
            ga = "git add";
            gc = "git commit";
            rebuild = "sudo nixos-rebuild switch --flake ~/nix-config#deathstar";
        };
    };

    programs.git = {
        enable = true;
        settings = {
            user.name = "Shin Morisawa";
            user.email = "git@tryh4rd.dev";
            commit.gpgSign = true;
        };     

        signing = {
            key = "8B8F8551938A9A71";
            signByDefault = true;
        };
    };

    programs.neovim = {
        enable = true;
        defaultEditor = true;
        extraPackages = with pkgs; [
            ripgrep
                fd
                lua-language-server
                nil
                gcc
                sqlite
                yaml-language-server
        ];
    };

    xdg.configFile."nvim".source = ./../../config/nvim;

    programs.home-manager.enable = true;
}
