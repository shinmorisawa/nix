{ config, pkgs, ... }:

{
    wayland.windowManager.mango = {
        enable = true;
        settings = {
            exec-once = [
                "eww open bar"
                "mako"
                "mpd-discord-rpc"
                "fcitx5 -d"
            ];

            monitorrule = [
                "serial:0x01010101,make:LG Electronics,model:22EA63,width:1920,height:1080,refresh:60,rr:3,x:1920,y:0"
                "serial:0x000028FB,make:LG Electronics,model:LG ULTRAGEAR,width:1920,height:1080,refresh:165,rr:0,vrr:1,x:0,y:0"
            ];

            tagrule = [
                "id:1,monitor_serial:0x000028FB,monitor_make:LG Electronics,monitor_model:LG ULTRAGEAR,layout_name:scroller"
            ];

            windowrule = [
                "isnamedscratchpad:1,width:1280,height:800,appid:dev.tryh4rd.ncmpcpp"
            ];

            blur = 1;
            blur_layer = 1;
            blur_params_radius = 8;
            blur_params_num_passes = 2;
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

            border_radius = 16;
            borderpx = 0;
            rootcolor = "0x000000ff";

            cursor_size = 32;
            cursor_theme = "Drop-WhiteRinal";

            bind = [
                "SUPER,t,spawn,ghostty"
                "SUPER,m,spawn,rofi -show drun -normal-window"

                "SUPER,h,focusstack,prev"
                "SUPER,l,focusstack,next"
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

                "SUPER,j,toggle_named_scratchpad,dev.tryh4rd.ncmpcpp,none,ghostty --class=dev.tryh4rd.ncmpcpp -e ncmpcpp --port 40220 --host 127.0.0.1"
            ];

            xkb_rules_options = caps:escape;

            drag_tile_to_tile = 1;

            mousebind = [
                "SUPER,btn_left,moveresize,curmove"
                "SUPER,btn_right,moveresize,curresize"
            ];
        };
        autostart_sh = ''

        '';
    };
}
