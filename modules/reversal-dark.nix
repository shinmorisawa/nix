{ pkgs }:

pkgs.stdenv.mkDerivation {
    name = "reversal-dark";
    src = ./../assets/Reversal-Dark;
    installPhase = ''
        mkdir -p $out/share/themes
        cp -r * $out/share/themes/
    '';
}
