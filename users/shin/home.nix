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
    ];


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
    };

    home.sessionPath = [ "/home/shin/.npm-global/bin" ];

    wayland.windowManager.mango = {
        enable = true;
        settings = {
            exec-once = [
                "waybar"
                "mako"
                "mpd-discord-rpc"
                "fcitx5 -d"
            ];

            monitorrule = [
                "serial:0x01010101,make:LG Electronics,model:22EA63,width:1920,height:1080,refresh:60,rr:3,x:1920,y:0"
                "serial:0x000028FB,make:LG Electronics,model:LG ULTRAGEAR,width:1920,height:1080,refresh:165,rr:0,vrr:1,x:0,y:0"
            ];

            blur = 1;
            blur_layer = 1;
            blur_params_radius = 8;
            blur_params_num_passes = 2;
            borderpx = 0;
            gappih = 4;
            gappiv = 4;
            gappoh = 8;
            gappov = 8;

            animation_type_open = "zoom";
            animation_type_close = "zoom";
            layer_animation_type_open = "slide";
            layer_animation_type_close = "slide";
            animation_duration_move = 200;
            animation_duration_open = 100;
            animation_duration_tag = 100;
            animation_duration_close = 200;
            animation_duration_focus = 0;
            animation_curve_open = "0.22,1,0.36,1";
            animation_curve_move = "0.22,1,0.36,1";
            animation_curve_tag = "0.22,1,0.36,1";
            animation_curve_close = "0.22,1,0.36,1";
            animation_curve_focus = "0.22,1,0.36,1";
            animation_curve_opafadein = "0.22,1,0.36,1";
            animation_curve_opafadeout = "0.5,0.5,0.5,0.5";

            border_radius=16;
            rootcolor="0x000000ff";

            cursor_size=32;
            cursor_theme="Drop-WhiteRinal";

            bind = [
                "SUPER,t,spawn,ghostty"
                "SUPER,m,spawn,rofi -show drun -normal-window"

                "SUPER,h,focusstack,next"
                "SUPER,l,focusstack,prev"
                "SUPER+SHIFT,i,incnmaster,+1"
                "SUPER,d,incnmaster,-1"

                "SUPER,u,setmfact,-0.05"
                "SUPER,o,setmfact,+0.05"
                "SUPER,Return,zoom,0"

                "SUPER,i,killclient"
                "SUPER,v,togglefloating"
                "SUPER,f,togglefullscreen"
                "SUPER,Tab,view,0"

                "SUPER,z,setlayout,tile"
                "SUPER,x,setlayout,floating"
                "SUPER,c,setlayout,scroller"
                "SUPER,space,setlayout,next"

                "SUPER,comma,focusmon,left"
                "SUPER,period,focusmon,right"
                "SUPER+SHIFT,less,tagmon,left"
                "SUPER+SHIFT,greater,tagmon,right"

                "SUPER,1,view,1"
                "SUPER,2,view,2"
                "SUPER,3,view,3"
                "SUPER,4,view,4"
                "SUPER,5,view,5"
                "SUPER,6,view,6"
                "SUPER,7,view,7"
                "SUPER,8,view,8"
                "SUPER,9,view,9"

                "SUPER+SHIFT,1,tag,1"
                "SUPER+SHIFT,2,tag,2"
                "SUPER+SHIFT,3,tag,3"
                "SUPER+SHIFT,4,tag,4"
                "SUPER+SHIFT,5,tag,5"
                "SUPER+SHIFT,6,tag,6"
                "SUPER+SHIFT,7,tag,7"
                "SUPER+SHIFT,8,tag,8"
                "SUPER+SHIFT,9,tag,9"

                "SUPER,0,view,0"
                "SUPER+SHIFT,parenright,tag,0"

                "SUPER+SHIFT,q,quit"
                "CTRL+ALT,BackSpace,quit"
            ];

            xkb_rules_options=caps:escape;

            drag_tile_to_tile=1;

            mousebind = [
                "SUPER,btn_left,moveresize,curmove"
                "SUPER,btn_right,moveresize,curresize"
            ];
        };
        autostart_sh = ''

        '';
    };


#home.packages = with pkgs; [
#    prismlauncher
#    discord
#];

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
