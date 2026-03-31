{ config, pkgs, ... }:

{
    services.printing.enable = true;
    services.flatpak.enable = true;

    services.libinput.enable = true;
    services.openssh.enable = true;

    services.pipewire = {
        enable = true;
        pulse.enable = true;
    };

    security.sudo.extraConfig = ''
        Defaults insults
    '';
}
