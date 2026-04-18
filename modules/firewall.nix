{ config, pkgs, ... }:

{
    networking.firewall = {
        enable = true;

        allowedTCPPorts = [
            80
            443
            22
            57423
        ];

        allowedUDPPorts = [
            443
        ];

        logRefusedConnections = false;
    };

    networking.firewall.interfaces."wlp4s0" = {
        allowedTCPPorts = [ 53 80 443 ];
        allowedUDPPorts = [ 53 67 68 ];
    };
}
