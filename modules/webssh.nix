{ config, pkgs, lib, myNeovim, ... }:

let
    devImage = pkgs.callPackage ./webssh-image.nix {
        inherit pkgs;
        custom-nvim = myNeovim;
    };
in 
{
    virtualisation.docker.enable = true;

    services.ttyd = {
        enable = true;
        port = 7681;
        writeable = true;
        entrypoint = [
            "${pkgs.docker}/bin/docker"
            "run" "-it" "--rm"
            "--network" "none" 
            "--cpus" "0.5"
            "--memory" "512M"
            "--pids-limit" "50"
            "--storage-opt" "size=1G"
            "--read-only"
            "--tmpfs" "/tmp:size=100M"
            "--tmpfs" "/home/dev:size=200M,exec,mode=1777"
            "dev-container:latest"
            "bash"
        ];
        clientOptions = {
            cursorStyle = "bar";
            cursorInactiveStyle = "outline";
            cursorWidth = "2";
            fontFamily = "JetBrainsMono Nerd Font, JetBrains Mono, monospace";
            fontSize = "16";
            cursorBlink = "true";
            theme = ''{
                "background":"#06080a",
                "black":"#06080a",
                "red":"#ee6d85",
                "green":"#95c561",
                "yellow":"#d7a65f",
                "blue":"#7199ee",
                "magenta":"#a485dd",
                "cyan":"#38a89d",
                "white":"#a0a8cd",
                "brightBlack":"#1f2335",
                "brightRed":"#ff757f",
                "brightGreen":"#c3e88d",
                "brightYellow":"#ffc777",
                "brightBlue":"#7aa2f7",
                "brightMangenta":"#bb9af7",
                "brightCyan":"#b4f9f8",
                "brightWhite":"#c0caf5",
            }'';
        };
    };

    systemd.services.ttyd = {
        after = [ "load-dev-container.service" ];
        environment = {
            LD_LIBRARY_PATH = "${pkgs.libwebsockets}/lib";
        };
    };

    systemd.services.load-dev-container = {
        description = "load";
        after = [ "docker.service" ];
        wantedBy = [ "default.target" ];
        serviceConfig = {
            Type = "oneshot";
            RemainAfterExit = true;
            ExecStart = "${pkgs.bash}/bin/bash -c '${pkgs.docker}/bin/docker load < ${devImage}'";
            Nice = "19";
        };
    };
}
