{ config, lib, pkgs, ... }:

{
    imports = [
        ../modules/nix.nix
        ../modules/boot.nix
        ../modules/networking.nix
        ../modules/filesystems.nix
        ../modules/graphics.nix

        ../modules/packages.nix
        ../modules/programs.nix
        ../modules/services.nix
        ../modules/i18n.nix

        ../modules/users.nix
        ../modules/settings.nix
        ../modules/xdg.nix

        ../modules/firewall.nix
        ../modules/fontconfig.nix

        ../modules/udev.nix

        ../modules/win98.nix
    ];
}
