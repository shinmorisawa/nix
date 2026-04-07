{ config, pkgs, ... }:

{
    environment.systemPackages = with pkgs; [
        mesa
        vim
        wget
        neovim
        git
        ghostty
        librewolf
        (dwl.overrideAttrs
            (
                oldAttrs: {
                    src = ./../repos/dwl-fork;
                    buildInputs = oldAttrs.buildInputs ++ [ wlroots_0_19 ];
                    patches = [];
                }
            )
        )
        pavucontrol
        mpd
        btop
        htop
        fastfetch
        tmux
        screen
        fd
        unzip
        zip
        unrar
        upx
        zstd
        gnutar
        go
        python3
        rustup
        gcc
        gdb
        strace
        valgrind
        nodejs
        jdk8
        jdk17
        jdk21
        rofi
        age
        ario
        mpd-discord-rpc
        mpdscribble
        (pkgs.callPackage ./../modules/reversal-dark.nix {})
        cava
        gnupg
        pinentry-curses
        grim
        mpc
        clang
        meson
        ninja
        cmake
        ffmpeg
        gnuplot
        gnumake
        pkg-config
        tinyxml-2
        tinyxml
        pkgsRocm.blender
        whois
        clang-tools
        harper
        zig
        gradle
        gpac
        picard
        nasm
        llvmPackages.bintools
        file
        crosspipe
        jetbrains.idea
        ollama-rocm
        deno
        kicad
        imagemagick
    ];
}
