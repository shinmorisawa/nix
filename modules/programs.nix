{ config, pkgs, ... }:

{
    programs.fish.enable = true;
    programs.xwayland.enable = true;
    programs.virt-manager.enable = true;
    programs.nix-ld.enable = true;
    programs.nix-ld.libraries = with pkgs; [
        fontconfig
        libx11
        libxext
        libxrender
        libxtst
        libxi
        libxrandr
        libxfixes
        libxcursor
        libxinerama
        libxcb
        glib
        gtk3
        libGL
        openssl
        zlib
        stdenv.cc.cc.lib
        fribidi
        freetype
        expat
        harfbuzz
    ];
    programs.ssh.startAgent = true;

    programs.gnupg.agent = {
        enable = true;
        pinentryPackage = pkgs.pinentry-curses;
    };
}

