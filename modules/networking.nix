{ config, pkgs, lib, ... }:

{
    networking = {
        hostName = "deathstar";
        networkmanager.enable = true;
        extraHosts = ''
            // according to deepseek (yes the irony)
            127.0.0.1 openai.com chatgpt.com
            127.0.0.1 api.openai.com
            127.0.0.1 claude.ai anthropic.com
            127.0.0.1 gemini.google.com
            127.0.0.1 perplexity.ai
            127.0.0.1 copilot.microsoft.com
            127.0.0.1 deepseek.com chat.deepseek.com
            127.0.0.1 grok.com x.ai
            127.0.0.1 character.ai
            127.0.0.1 poe.com
            127.0.0.1 meta.ai
            127.0.0.1 kimi.com
            127.0.0.1 chat.qwen.ai
            127.0.0.1 manus.im manus.ai
            127.0.0.1 you.com
            127.0.0.1 venice.ai
        '';

        interfaces.enp5s0 = {
            ipv6.addresses = [{
                address = "240f:93:dd5:1::1";
                prefixLength = 64;
            }];
            ipv4.addresses = [{
                address = "192.168.0.222";
                prefixLength = 19;
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

    networking.dhcpcd.extraConfig = ''
        interface enp5s0
        ia_pd 1 {
            ia_idassgn 1 {
                suffix 1; # this forces the host part to be ::1
            }
        }
    '';

    boot.kernel.sysctl = {
        "net.ipv6.conf.enp5s0.use_tempaddr" = lib.mkForce 0;
    };
}
