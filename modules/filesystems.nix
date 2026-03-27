{ config, pkgs, ... }:

{
    fileSystems."/var/www/files/projects" = {
        device = "/home/shin/programming/projects";
        options = [ "bind" "ro" ];
    };

    fileSystems."/var/www/files/pfp" = {
        device = "/home/shin/Pictures/pfp";
        options = [ "bind" "ro" ];
    };

    fileSystems."/var/www/files/torrents" = {
        device = "/home/shin/hd/torrents";
        options = [ "bind" "ro" ];
    };
}
