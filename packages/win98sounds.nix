{ lib, stdenv }:

stdenv.mkDerivation {
    name = "win98-sounds";
    src = ../assets/sounds/win98;
    installPhase = ''
        mkdir -p $out/share/sounds/win98
        cp ./* $out/share/sounds/win98
    '';
}
