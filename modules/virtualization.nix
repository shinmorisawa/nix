{ config, pkgs, ... }:

{
    virtualisation.libvirtd = {
        enable = true;
        qemu = {
            package = pkgs.qemu_kvm;
            runAsRoot = true;
            swtpm.enable = true;
        };
    };

    users.users.shin.extraGroups = [ "libvirtd" ];
}
