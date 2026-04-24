{ pkgs, custom-nvim }:

pkgs.dockerTools.buildLayeredImage {
    name = "dev-container";
    tag = "latest";

    contents = with pkgs; [
        coreutils 
        bashInteractive
        clang
        meson
        ninja
        custom-nvim
        gcc
    ];

    extraCommands = ''
        mkdir -p home/dev/.config
        mkdir -p home/dev/.local/share/nvim
        ln -s ${custom-nvim}/share/nvim home/dev/.local/share/nvim
    '';

    config = {
        Cmd = [ "${pkgs.bashInteractive}/bin/bash" ];
        WorkingDir = "/home/dev";
        Env = [
            "PATH=/usr/bin:/bin"
            "TERM=xterm-256color"
            "XDG_DATA_HOME=/home/dev/.local/share"
            "XDG_CONFIG_HOME=/home/dev/.config" 
            "HOME=/home/dev"
        ];
    };
}
