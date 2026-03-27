{ pkgs }:

pkgs.stdenv.mkDerivation {
    pname = "fonts";
    version = "1.0";
    src = ../assets/fonts;
    installPhase = ''
        mkdir -p $out/share/fonts/opentype
        cp -R $src/**/*.otf $out/share/fonts/opentype/
    '';
}
