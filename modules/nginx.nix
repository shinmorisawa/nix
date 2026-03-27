{ pkgs, ... }:

{
    services.nginx.enable = true;

    systemd.services.nginx.serviceConfig.ReadOnlyPaths = [ 
        "/home/shin/programming" 
        "/home/shin/Pictures" 
        "/home/shin/hd" 
    ];

    security.acme = {
        acceptTerms = true;
        defaults.email = "me@tryh4rd.dev";
        certs."tryh4rd.dev" = {
            domain = "tryh4rd.dev";
            extraDomainNames = [ "*.tryh4rd.dev" "*.ygg.tryh4rd.dev" ];
            dnsProvider = "cloudflare";
            credentialsFile = "/var/lib/secrets/acme-cloudflare.env";

            group = "nginx";
        };
    };

    users.users.nginx.extraGroups = [ "acme" "shin" ];

    services.nginx.virtualHosts = {
        "tryh4rd.dev" = {
            forceSSL = true;
            useACMEHost = "tryh4rd.dev";
            root = "/var/www/root-svelte";

            locations."/" = {
                extraConfig = "try_files $uri $uri.html $uri/ =404;";
            };

            extraConfig = ''
                charset utf-8;
            add_header Access-Control-Allow-Origin "*";
            error_page 404 /404;
            disable_symlinks off;
            '';
        };

        "ygg.tryh4rd.dev" = {
            listen = [ 
            { addr = "[200:fe:9c30:f999:4:4:b3d9:1b]"; port = 80; }
            { addr = "[200:fe:9c30:f999:4:4:b3d9:1b]"; port = 443; ssl = true; } 
            ];
            extraConfig = ''
                ssl_certificate /var/lib/acme/tryh4rd.dev/fullchain.pem;
            ssl_certificate_key /var/lib/acme/tryh4rd.dev/key.pem;
            ssl_trusted_certificate /var/lib/acme/tryh4rd.dev/chain.pem;
            '';
            useACMEHost = "tryh4rd.dev";
            root = "/var/www/root-svelte-ygg";
            locations."/" = {
                extraConfig = "try_files $uri $uri.html $uri/ =404;";
            };
        };

        "files.ygg.tryh4rd.dev" = {
            listen = [ 
            { addr = "[200:fe:9c30:f999:4:4:b3d9:1b]"; port = 80; }
            { addr = "[200:fe:9c30:f999:4:4:b3d9:1b]"; port = 443; ssl = true; } 
            ];
            extraConfig = ''
                ssl_certificate /var/lib/acme/tryh4rd.dev/fullchain.pem;
            ssl_certificate_key /var/lib/acme/tryh4rd.dev/key.pem;
            ssl_trusted_certificate /var/lib/acme/tryh4rd.dev/chain.pem;
            '';
            useACMEHost = "tryh4rd.dev";
            root = "/var/www/files";
            locations."/".extraConfig = "autoindex on;";
        };

        "api.tryh4rd.dev" = {
            forceSSL = true;
            useACMEHost = "tryh4rd.dev";
            http3 = true;
            locations."/go-rest" = {
                proxyPass = "http://localhost:5002";
                proxyWebsockets = true;
            };
            locations."/tiny/ip" = {
                extraConfig = ''
                    default_type text/plain;
                return 200 $remote_addr;
                add_header Access-Control-Allow-Origin "*";
                '';
            };
            locations."/tiny/" = {
                proxyPass = "http://localhost:8086/";
                proxyWebsockets = true;
            };
            extraConfig = ''
                charset utf-8;
            add_header Access-Control-Allow-Origin "https://tryh4rd.dev/";
            '';
        };

        "files.tryh4rd.dev" = {
            forceSSL = true;
            useACMEHost = "tryh4rd.dev";
            root = "/var/www/files";
            locations."/".extraConfig = "autoindex on;";
        };

        "js.tryh4rd.dev" = {
            forceSSL = true;
            useACMEHost = "tryh4rd.dev";
            root = "/var/www/js";
            extraConfig = "add_header Access-Control-Allow-Origin \"https://tryh4rd.dev/\";";
        };

        "static.tryh4rd.dev" = {
            forceSSL = true;
            useACMEHost = "tryh4rd.dev";
            root = "/var/www/static";
        };

        "mc.tryh4rd.dev" = {
            forceSSL = true;
            useACMEHost = "tryh4rd.dev";
            locations."/map".root = "/home/shin/paper/bluemap/web";
        };

        "radio.tryh4rd.dev" = {
            forceSSL = true;
            useACMEHost = "tryh4rd.dev";
            locations."/".proxyPass = "http://127.0.0.1:8023";
        };

        "svelte.tryh4rd.dev" = {
            forceSSL = true;
            useACMEHost = "tryh4rd.dev";
            locations."/".proxyPass = "http://localhost:5173";
        };
    };
}
