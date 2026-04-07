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
        NPM_CONFIG_PREFIX = "$HOME/.npm-global";
    };

    home.sessionPath = [ "/home/shin/.npm-global/bin" ];

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
        plugins = with pkgs.vimPlugins; [
            (nvim-treesitter.withPlugins (p: [
                p.c p.lua p.nix p.rust
                p.typescript p.javascript
                p.tsx p.html p.css
                p.json p.yaml p.bash
                p.markdown p.svelte
            ]))
        ];
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

    xdg.configFile."nvim".source = ./../../config/nvim;

    programs.cava = {
        enable = true;
        settings = {
            general.framerate = 165;
            general.bar_width = 3;
            general.bar_spacing = 0;
            input.method = "pipewire";
            output = {
                channels = "mono";
                mono_option = "average";
            };
            smoothing.noise_reduction = 20;
        };
    };

    programs.librewolf = {
        enable = true;
        settings = {
            "webgl.disabled" = false;
        };
    };

    services.mako = {
        enable = true;
        settings = {
            actions = true;
            anchor = "top-right";
            background-color = "#000000";
            border-color = "#ffffff";
            border-size = 2;
            border-radius = 16;
            icon-border-radius = 16;
            markup = true;
            layer = "overlay";
            height = 200;
            width = 400;
            icons = true;
            font = "SF Pro Text 12";
        };
    };
    services.mpdscribble = {
        enable = true;
        host = "127.0.0.1";
        port = 40220;
        package = pkgs.mpdscribble;
    };

    programs.home-manager.enable = true;
}
