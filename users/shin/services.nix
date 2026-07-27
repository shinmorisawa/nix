{ config, pkgs, ... }:

{
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
        endpoints = {
            "last.fm" = {
                passwordFile = "/var/lib/secrets/lastfm.key";
                username = "tryh4rd3rr";
            };
        };
    };
}
