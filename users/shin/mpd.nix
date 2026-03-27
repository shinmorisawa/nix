{ pkgs, ... }:

{
    xdg.configFile."mpd/playlists".source = ./../../config/mpd/playlists;
    services.mpd = {
        enable = true;
        musicDirectory = "/home/shin/hd/torrents/what-i-listen-to";
        playlistDirectory = "/home/shin/.config/mpd/playlists";
        dbFile = "/home/shin/.config/mpd/database";

        network = {
            listenAddress = "127.0.0.1";
            port = 40220;
        };

        extraConfig = ''
            filesystem_charset "UTF-8"
            audio_output {
                type "pipewire"
                    name "pipewire"
            }
        '';
    };
}
