{ config, pkgs, lib, ... }:

{
    networking = {
        hostName = "deathstar";
        networkmanager.enable = true;

        interfaces.enp5s0 = {
            ipv6.addresses = [{
                address = "240f:93:dd5:1::1";
                prefixLength = 64;
            }];
            ipv4.addresses = [{
                address = "192.168.0.222";
                prefixLength = 18;
            }];
        };

        defaultGateway = {
            address = "192.168.0.1";
            interface = "enp5s0";
        };

        defaultGateway6 = {
            address = "fe80::f652:46ff:feee:d380";
            interface = "enp5s0";
        };

        hosts = {
            "127.0.0.1" = [ "files.tryh4rd.dev" "static.tryh4rd.dev" "js.tryh4rd.dev" "api.tryh4rd.dev" ];
        };

        nameservers = [
            "1.1.1.1" "8.8.8.8"
        ];

        networkmanager.unmanaged = [ "wlp4s0" ];
    };

    boot.kernel.sysctl = {
        "net.ipv6.conf.enp5s0.use_tempaddr" = lib.mkForce 0;
    };
}
