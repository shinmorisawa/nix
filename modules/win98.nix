{ config, pkgs, ... }:

let
win98-sounds = pkgs.callPackage ../packages/win98sounds.nix {};
in 
{
    systemd.services.win98-boot.enable = false;
    systemd.services.win98-shutdown.enable = false;
    users.users.shin.linger = true;

    systemd.user.services = {
        win98-boot = {
            enable = true;
            description = "win98 boot sound";
            wantedBy = [ "graphical-session.target" ];
            wants = [ "pipewire.service" "wireplumber.service" ];
            after = [ "graphical-session.target" "pipewire.service" "wireplumber.service" ];

            serviceConfig = {
                Type = "oneshot";
                ExecStart = "${pkgs.bash}/bin/bash -c '${pkgs.coreutils}/bin/sleep 2 && ${pkgs.pipewire}/bin/pw-play \"${win98-sounds}/share/sounds/win98/The Microsoft Sound.wav\"'";
            };
        };

        win98-login = {
            enable = true;
            description = "win98 login sound";
            wantedBy = [ "graphical-session.target" ];
            after = [ "win98-boot.service" ];

            serviceConfig = {
                Type = "oneshot";
                ExecStart = "${pkgs.pipewire}/bin/pw-play \"${win98-sounds}/share/sounds/win98/ding.wav\"";
            };
        };

        win98-shutdown = {
            enable = true;
            description = "win98 shutdown sound";
            wantedBy = [ "graphical-session.target" ];
            before = [ "graphical-session.target" ];

            serviceConfig = {
                Type = "oneshot";
                RemainAfterExit = true;
                ExecStart = "${pkgs.coreutils}/bin/true";
                ExecStop = "${pkgs.pipewire}/bin/pw-play \"${win98-sounds}/share/sounds/win98/chimes.wav\"";
            };
        };
    };
}
