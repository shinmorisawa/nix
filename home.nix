{ config, pkgs, ... }:

{
    home.username = "shin";
    home.homeDirectory = "/home/shin";
    home.stateVersion = "25.11";

    #home.packages = with pkgs; {
    #    prismlauncher
    #    discord
    #};

    programs.fish = {
        enable = true;
        shellAliases = {
            ga = "git add";
            gc = "git commit";
            rebuild = "sudo nixos-rebuild switch --flake ~/nix-config#deathstar";
        };
    };

    programs.home-manager.enable = true;
}
