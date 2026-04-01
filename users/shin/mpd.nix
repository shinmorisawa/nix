{ pkgs, ... }:

{
    xdg.configFile."mpd/playlists".source = ./../../config/mpd/playlists;
    services.mpd = {
        enable = true;
        musicDirectory = "/home/shin/hd/torrents/what-i-listen-to";
        playlistDirectory = "/home/shin/.mpd/playlists";
        dbFile = "/home/shin/.mpd/database";

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

    services.mpd-discord-rpc = {
        enable = true;
        settings = {
            id = 677226551607033903;
            hosts = [ "localhost:40220" ];
            format = {
                details = "$title";
                state = "$title by $artist";
                timestamp = "both";
                large_image = "notes";
                small_image = "";
                large_text = "i use nixos btw :3";
                small_text = "i don't like spotify ;)";
                display_type = "state";
            };
        };
    };

    xdg.configFile."discord-rpc/config.toml".force = true;
}
