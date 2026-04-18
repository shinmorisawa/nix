{ lib, stdenv, fetchFromGitHub }:

stdenv.mkDerivation rec {
    pname = "anime4k-shaders";
    version = "4.0.1";

    src = fetchFromGitHub {
        owner = "bloc97";
        repo = "Anime4K";
        rev = "v${version}";
        sha256 = "sha256-OQWJWcDpwmnJJ/kc4uEReaO74dYFlxNQwf33E5Oagb0=";
    };

    installPhase = ''
        mkdir -p $out/share/anime4k
        cp -r glsl/* $out/share/anime4k
    '';

    meta = with lib; {
        description = "anime shaders";
        homepag = "https://github.com/bloc97/Anime4K";
        license = licenses.mit;
        platforms = platforms.all;
    };
}
