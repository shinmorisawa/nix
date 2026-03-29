{ config, pkgs, ... }:

{
    programs.fish.enable = true;
    programs.xwayland.enable = true;
    programs.virt-manager.enable = true;
    programs.nix-ld.enable = true;
    programs.ssh.startAgent = true;

    programs.gnupg.agent = {
        enable = true;
        pinentryPackage = pkgs.pinentry-curses;
    };
}

