{ config, pkgs, ... }:

{
    services.yggdrasil = {
        enable = true;

        settings = {
            Peers = [
                "tls://133.18.201.69:54232"
                "tls://yg-tyo.magicum.net:32333"
                "tls://193.93.119.42:443"
                "tls://ygg.jjolly.dev:3443"
                "tls://leo.node.3dt.net:9003"
                "tls://185.165.169.234:8443"
                "tls://cirno.nadeko.net:44442"
                "quic://185.181.60.111:1513?key=00defa4b4b243547f2d5641ac5235ff1e35d393c576e4bb9cd45baefc81e48d9"
                "tls://srl.newsdeef.eu:59999"
                "tls://des.8px.sk:4321"
                "quic://ip4.fvm.mywire.org:443?key=000000000143db657d1d6f80b5066dd109a4cb31f7dc6cb5d56050fffb014217"
                "quic://ygg-hel-1.wgos.org:45171"
                "tls://ygg.nadeko.net:44442"
            ];

            Listen = [
                "tls://0.0.0.0:41337"
            ];

            PrivateKeyPath = "/var/lib/secrets/yggdrasil.key";
        };
    };
}
