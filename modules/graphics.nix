{ config, pkgs, ... }:

{
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
}
