{ config, pkgs, ... }:

{
    services.udev.extraRules = ''
        SUBSYSTEM=="usb", ATTR{idVendor}=="0955", MODE="0664", GROUP="plugdev"
    '';
}
