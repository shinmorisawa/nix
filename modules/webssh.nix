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
            "--memory" "512m"
            "--pids-limit" "50"
            "dev-container:latest"
            "bash"
        ];
    };

    systemd.services.ttyd = {
        after = [ "load-dev-container.service" ];
    };

    systemd.services.load-dev-container = {
        description = "load";
        after = [ "docker.service" ];
        wantedBy = [ "multi-user.target" ];
        serviceConfig = {
            Type = "oneshot";
            RemainAfterExit = true;
            ExecStart = "${pkgs.bash}/bin/bash -c '${pkgs.docker}/bin/docker load < ${devImage}'";
        };
    };
}
