{ config, pkgs, ... }:

{
    services.fstrim.enable = false;

    services.printing.enable = true;
    services.flatpak.enable = true;

    services.libinput.enable = true;

    services.pipewire = {
        enable = true;
        pulse.enable = true;
    };

    security.sudo.extraConfig = ''
        Defaults insults
    '';

    services.openssh = {
        enable = true;
        settings = {
            PasswordAuthentication = false;
            KbdInteractiveAuthentication = false;

            PermitRootLogin = "prohibit-password";
        };
    };

    services.speechd.enable = false; # why was this in here?
    services.timesyncd.enable = false;
    services.chrony.enable = true;

    services.greetd = {
        enable = true;
        settings = {
            default_session = {
                command = "${pkgs.tuigreet}/bin/tuigreet --time --cmd mango";
                user = "greeter";
            };
        };
    };
    systemd.services.greetd.serviceConfig = {
        Type = "idle";
        StandardInput = "tty";
        StandardOutput = "tty";
        StandardError = "journal";
        TTYReset = true;
        TTYVHangup = true;
        TTYVTDisallocate = true;
    };
}
