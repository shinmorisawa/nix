{ config, pkgs, ... }:

let
    win98-sounds = pkgs.callPackage ../packages/win98sounds.nix {};
in 
{
    systemd.services.win98-boot = { enable = false; };
    systemd.services.win98-shutdown = { enable = false; };

    systemd.user.services = {
        win98-boot = {
            enable = true;
            description = "win98 boot sound";
            wantedBy = [ "graphical-session.target" ];
            requires = [ "pipewire.socket" ];
            after = [ "graphical-session.target" "pipewire.service" "wireplumber.service" ];
            serviceConfig = {
                Type = "oneshot";
                ExecStart = "${pkgs.bash}/bin/bash -c '${pkgs.coreutils}/bin/sleep 1 && ${pkgs.pipewire}/bin/pw-play \"${win98-sounds}/share/sounds/win98/The Microsoft Sound.wav\" || true'";
                RemainAfterExit = true;
            };
        };

        win98-login = {
            enable = true;
            description = "win98 login sound";
            wantedBy = [ "graphical-session.target" ];
            requires = [ "pipewire.socket" ];
            after = [ "win98-boot.service" "pipewire.service" "wireplumber.service" ];
            serviceConfig = {
                Type = "oneshot";
                ExecStart = "${pkgs.bash}/bin/bash -c '${pkgs.pipewire}/bin/pw-play \"${win98-sounds}/share/sounds/win98/ding.wav\" || true'";
                RemainAfterExit = true;
            };
        };

        win98-shutdown = {
            enable = true;
            description = "win98 shutdown sound";
            wantedBy = [ "graphical-session.target" ];
            requires = [ "pipewire.socket" ];
            after = [ "pipewire.service" ];
            serviceConfig = {
                Type = "oneshot";
                RemainAfterExit = true;
                ExecStart = "${pkgs.coreutils}/bin/true";
                ExecStop = "${pkgs.bash}/bin/bash -c '${pkgs.pipewire}/bin/pw-play \"${win98-sounds}/share/sounds/win98/chimes.wav\" || true'";
            };
        };
    };
}
