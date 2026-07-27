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

    programs.ncmpcpp = {
        enable = true;
        bindings = [
            { command = "scroll_down"; key = "j"; }
            { command = "scroll_up"; key = "k"; }
            { command = "select_item"; key = "v"; }
            { command = "play_item"; key = "enter"; }
            { command = "add_selected_items"; key = "a"; }
            { command = "delete_playlist_items"; key = "d"; }
            { command = "play"; key = "space"; }
            { command = "pause"; key = "space"; }
            { command = "stop"; key = "space"; }
            { command = "next"; key = "l"; }
            { command = "previous"; key = "h"; }
            { command = "seek_forward"; key = "L"; }
            { command = "seek_backward"; key = "H"; }
            { command = "volume_up"; key = "="; }
            { command = "volume_down"; key = "-"; }
        ];
    };

    xdg.configFile."discord-rpc/config.toml".force = true;
}
