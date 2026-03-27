# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, lib, pkgs, ... }:

{
    imports =
        [ # Include the results of the hardware scan.
        ./hardware-configuration.nix
            ./system/nginx.nix
        ];

    nix.gc = {
        automatic = true;
        dates = "daily";
        options = "--delete-older-than 7d";
    };
    nix.optimise.automatic = true;
    nix.settings.experimental-features = [ "nix-command" "flakes" ];
    nixpkgs.config.allowUnfree = true;
    nixpkgs.config.permittedInsecurePackages = [
        "libsoup-2.74.3"
    ];

    systemd.services.nginx.serviceConfig.ReadOnlyPaths = [ 
        "/home/shin/programming" 
        "/home/shin/Pictures" 
        "/home/shin/hd" 
    ];

    fileSystems."/var/www/files/projects" = {
        device = "/home/shin/programming/projects";
        options = [ "bind" "ro" ];
    };

    fileSystems."/var/www/files/pfp" = {
        device = "/home/shin/Pictures/pfp";
        options = [ "bind" "ro" ];
    };

    fileSystems."/var/www/files/torrents" = {
        device = "/home/shin/hd/torrents";
        options = [ "bind" "ro" ];
    };

# Use the systemd-boot EFI boot loader.
    boot.loader.systemd-boot.enable = true;
    boot.loader.efi.canTouchEfiVariables = true;

# Use latest kernel.
    boot.kernelPackages = pkgs.linuxPackages_latest;

    networking.hostName = "deathstar"; # Define your hostname.

# Configure network connections interactively with nmcli or nmtui.
        networking.networkmanager.enable = true;

# Set your time zone.
    time.timeZone = "Asia/Tokyo";

# Configure network proxy if necessary
# networking.proxy.default = "http://user:password@proxy:port/";
# networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

# Select internationalisation properties.
# i18n.defaultLocale = "en_US.UTF-8";
# console = {
#   font = "Lat2-Terminus16";
#   keyMap = "us";
#   useXkbConfig = true; # use xkb.options in tty.
# };

# Enable the X11 windowing system.
# services.xserver.enable = true;

# Configure keymap in X11
# services.xserver.xkb.layout = "us";
# services.xserver.xkb.options = "eurosign:e,caps:escape";

# Enable CUPS to print documents.
    services.printing.enable = true;
    services.flatpak.enable = true;
    xdg.portal.enable = true;
    xdg.portal.extraPortals = with pkgs; [
        xdg-desktop-portal-wlr
        xdg-desktop-portal-gtk
    ];
    xdg.portal.config.common.default = "*";

# Enable sound.
# services.pulseaudio.enable = true;
# OR
    services.pipewire = {
        enable = true;
        pulse.enable = true;
    };

# Enable touchpad support (enabled default in most desktopManager).
    services.libinput.enable = true;

# Define a user account. Don't forget to set a password with ‘passwd’.
    users.users.shin = {
        isNormalUser = true;
        extraGroups = [ "wheel" "video" "networkmanager" "audio" "render" ]; # Enable ‘sudo’ for the user.
            packages = with pkgs; [
            tree
            ];
        shell = pkgs.fish;
        openssh.authorizedKeys.keys = [
            "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJFixXDg9u5dpHX9NS3+SJshRQiVRC7TiaL8XChk7oO/ ish-key"
                "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINuv6ONKoNwtpg3Lz+zh7AKv/+M61p5A9CxwO0TJ6F8P Shortcuts on Shin’s iPhone"
        ];
    };

    programs.fish.enable = true;
    programs.xwayland.enable = true;
    programs.virt-manager.enable = true;
    programs.ssh.startAgent = true;
    virtualisation.libvirtd.enable = true;

# List packages installed in system profile.
#You can use https://search.nixos.org/ to find more packages (and options).
    environment.systemPackages = with pkgs; [
        vim
            wget
            neovim
            git
            ghostty
            fish
            librewolf
            (dwl.overrideAttrs (
                                oldAttrs: {
                                src = ./repos/dwl-fork;
                                buildInputs = oldAttrs.buildInputs ++ [ wlroots_0_19 ];
                                patches = [];
                                }))
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
        age # for my ssh keys
        ario
        mpd-discord-rpc
        mpdscribble
        (pkgs.callPackage ./pkgs/reversal-dark.nix {})
        cava
    ];

    fonts.packages = with pkgs; [
        noto-fonts-cjk-sans
            noto-fonts
            noto-fonts-color-emoji
            nerd-fonts.jetbrains-mono
            (pkgs.callPackage ./pkgs/fonts.nix {})
    ];

    fonts.fontconfig = {
        enable = true;

        antialias = true;
        hinting = {
            enable = true;
            style = "slight";
            autohint = false;
        };
        subpixel = {
            rgba = "rgb";
            lcdfilter = "default";
        };

        defaultFonts = {
            sansSerif = [ "SF Pro Text" "Apple Color Emoji" ];
            serif     = [ "SF Compact Text" "Apple Color Emoji" ];
            monospace = [ "JetBrains Mono Nerd Font" "Apple Color Emoji" ];
        };
    };

    hardware.graphics = {
        enable = true;
        enable32Bit = true;
        extraPackages = with pkgs; [
            libvdpau-va-gl
        ];
    };

    hardware.amdgpu = {
        opencl = {
            enable = true;
        };
    };

# Some programs need SUID wrappers, can be configured further or are
# started in user sessions.
# programs.mtr.enable = true;
# programs.gnupg.agent = {
#   enable = true;
#   enableSSHSupport = true;
# };

# List services that you want to enable:

# Enable the OpenSSH daemon.
    services.openssh.enable = true;

# Open ports in the firewall.
# networking.firewall.allowedTCPPorts = [ ... ];
# networking.firewall.allowedUDPPorts = [ ... ];
# Or disable the firewall altogether.
# networking.firewall.enable = false;
    networking.firewall = {
        enable = true;

        allowedTCPPorts = [
            80
                443
                22
        ];

        allowedUDPPorts = [
            443
        ];
    };

# Copy the NixOS configuration file and link it from the resulting system
# (/run/current-system/configuration.nix). This is useful in case you
# accidentally delete configuration.nix.
# system.copySystemConfiguration = true;

# This option defines the first version of NixOS you have installed on this particular machine,
# and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
#
# Most users should NEVER change this value after the initial install, for any reason,
# even if you've upgraded your system to a new NixOS release.
#
# This value does NOT affect the Nixpkgs version your packages and OS are pulled from,
# so changing it will NOT upgrade your system - see https://nixos.org/manual/nixos/stable/#sec-upgrading for how
# to actually do that.
#
# This value being lower than the current NixOS release does NOT mean your system is
# out of date, out of support, or vulnerable.
#
# Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
# and migrated your data accordingly.
#
# For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
    system.stateVersion = "25.11"; # Did you read the comment?

}
