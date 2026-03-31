{ config, lib, pkgs, ... }:

{
    imports = [
        ./hardware-configuration.nix
        ./modules/nix.nix
        ./modules/boot.nix
        ./modules/networking.nix
        ./modules/filesystems.nix
        ./modules/graphics.nix

        ./modules/packages.nix
        ./modules/programs.nix
        ./modules/services.nix

        ./modules/users.nix
        ./modules/settings.nix
        ./modules/virtualization.nix

        ./modules/nginx.nix
        ./modules/yggdrasil.nix
        ./modules/xdg.nix

        ./modules/firewall.nix
        ./modules/fontconfig.nix
    ];
}
