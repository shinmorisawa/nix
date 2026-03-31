{ config, pkgs, lib, ... }:

{
    nix.gc = {
        automatic = true;
        dates = "daily";
        options = "--delete-older-than 7d";
    };
    nix.optimise.automatic = true;
    nix.settings.experimental-features = [ "nix-command" "flakes" ];
    nixpkgs.config.allowUnfree = true;
    nixpkgs.config.rocmSupport = true;
    nixpkgs.config.permittedInsecurePackages = [
        "libsoup-2.74.3"
    ];

    system.stateVersion = "25.11";
}
