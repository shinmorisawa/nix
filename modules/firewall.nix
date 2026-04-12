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
    };
}
