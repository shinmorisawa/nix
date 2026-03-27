{ config, lib, pkgs, ... }:

{
    imports = [
        ./hardware-configuration.nix
        ./modules/boot.nix
        ./modules/filesystems.nix
        ./modules/firewall.nix
        ./modules/fontconfig.nix
        ./modules/graphics.nix
        ./modules/networking.nix
        ./modules/nginx.nix
        ./modules/nix.nix
        ./modules/packages.nix
        ./modules/programs.nix
        ./modules/services.nix
        ./modules/settings.nix
        ./modules/users.nix
        ./modules/virtualization.nix
        ./modules/xdg.nix
    ];
}
