{ config, pkgs, ... }:

{
    fileSystems."/var/www/files/projects" = {
        device = "/home/shin/programming/projects";
        fsType = "none";
        options = [ "bind" "ro" ];
    };

    fileSystems."/var/www/files/pfp" = {
        device = "/home/shin/Pictures/pfp";
        fsType = "none";
        options = [ "bind" "ro" ];
    };

    fileSystems."/var/www/files/torrents" = {
        device = "/home/shin/hd/torrents";
        fsType = "none";
        options = [ "bind" "ro" ];
    };
}
