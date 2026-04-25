{ pkgs, custom-nvim }:

pkgs.dockerTools.buildLayeredImage {
    name = "dev-container";
    tag = "latest";

    contents = with pkgs; [
        coreutils-full
        binutils
        bashInteractive
        clang
        meson
        ninja
        custom-nvim
        gcc
        fastfetch
        btop
        htop
        cbonsai
        cmatrix
        pipes-rs
        tree
        fd
        fzf
        jq
        bat
        man
        man-pages
        gdb
        strace
        ninvaders
        greed
    ];

    extraCommands = ''
        mkdir -p home/dev/.config
        mkdir -p home/dev/.local/share/nvim
        mkdir -p tmp
        mkdir -p etc
        ln -s ${custom-nvim}/share/nvim home/dev/.local/share/nvim
        echo -e "welcome to ssh.tryh4rd.dev! this is a little terminal running in a docker container on my\nmain desktop, please don't fork bomb or malloc hell this. thanks!\n" > etc/motd
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
            "PS1=@\\[\\e[34m\\]tryh4rd\\[\\e[m\\]:\\[\\e[33m\\]\\w\\[\\e[m\\]\\$ "
        ];
    };
}
