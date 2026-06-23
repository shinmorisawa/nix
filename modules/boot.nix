{ config, pkgs, ... }:

{
    boot.loader.systemd-boot.enable = true;
    boot.loader.efi.canTouchEfiVariables = true;
    boot.kernel.sysctl = {
        "kernel.sysrq" = 1;
    };

    boot.kernelPackages = pkgs.linuxPackages_zen;
}
