{ config, pkgs, ... }:

{
    home.username = "shin";
    home.homeDirectory = "/home/shin";
    home.stateVersion = "25.11";

    home.sessionVariables = {
        XDG_CURRENT_DESKTOP = "sway";
        XDG_SESSION_TYPE = "wayland";
        WLR_NO_HARDWARE_CURSORS = "1";
        XCURSOR_PATH = "/home/shin/.local/share/icons";
        XCURSOR_THEME = "Drop-WhiteRinal";
        XCURSOR_SIZE = "32";
        WLR_DEBUG = "1";
        NPM_CONFIG_PREFIX = "$HOME/.npm-global";
        PAGER = "nvim -R -";
        MANPAGER = "nvim +Man!";
    };

    home.sessionPath = [ "/home/shin/.npm-global/bin" ];

    programs.fish = {
        enable = true;
        shellAliases = {
            ga = "git add";
            gc = "git commit";
            rebuild = "doas nixos-rebuild switch --flake ~/nix-config#deathstar";
            sudo = "doas";
        };
        interactiveShellInit = ''
            set -gx PATH /run/wrappers/bin $PATH
        '';
    };

    programs.starship = {
        enable = true;
        settings = {
            palette = "tokyodark";
            format = ''
            $directory
            $character
            '';
            character = {
                success_symbol = "[(green)>](peach)";
                error_symbol = "[(red)>](peach)";
                vimcmd_symbol = "[<](subtext1)";
            };
            git_branch = {
                style = "bold mauve";
            };
            directory = {
                style = "bold mauve";
                truncation_length = 4;
            };
            palettes.tokyodark = {
                mauve = "#A485DD";
                red = "#EE6D85";
                peach = "#F6955B";
                yellow = "#D7A65F";
                green = "#95C561";
                teal = "#38A89D";
                blue = "#7199EE";
                text = "#A0A8CD";
                subtext1 = "#bac2de";
                subtext0 = "#a6adc8";
                overlay2 = "#9399b2";
                overlay1 = "#7f849c";
                overlay0 = "#6c7086";
                surface2 = "#4A5057";
                surface1 = "#353945";
                surface0 = "#212234";
                base = "#1A1B2A";
                mantle = "#11121D";
                crust = "#06080A";
            };
        };
    };
}
