{ config, pkgs, lib, ... }:

{
    services.hostapd = {
        enable = true;
        radios.wlp4s0 = {
            networks.wlp4s0 = {
                ssid = "animosity";
                authentication = {
                    mode = "wpa3-sae";
                    saePasswords = [{
                        password = "deathstar_test";
                    }];
                };
                settings = {

                    ieee80211w = 2;
                };
            };

            band = "2g";
            channel = 1;
            settings = {
                wmm_enabled = true;
                country_code = "JP";
                ieee80211d = true;
                ieee80211h = true;
                ieee80211n = true;
            };
        };
    };

    services.kea.dhcp4 = {
        enable = true;
        settings = {
            interfaces-config.interfaces = [ "wlp4s0" ];
            lease-database = {
                type = "memfile";
                persist = true;
                name = "/var/lib/kea/dhcp4.leases";
            };
            subnet4 = [{
                id = 1;
                subnet = "10.13.37.0/18";
                pools = [{ pool = "10.13.38.0 - 10.13.39.255"; }];
                option-data = [
                    { name = "routers"; data = "10.13.37.1"; }
                    { name = "domain-name-servers"; data = "1.1.1.1, 8.8.8.8"; }
                ];
            }];
        };
    };

    networking.interfaces.wlp4s0.ipv4.addresses = [{
        address = "10.13.37.1";
        prefixLength = 18;
    }];

    networking.nat = {
        enable = true;
        internalInterfaces = [ "wlp4s0" ];
        externalInterface = "enp5s0";
    };

    networking.nftables.enable = true;
    networking.firewall.extraForwardRules = ''
    '';
}
