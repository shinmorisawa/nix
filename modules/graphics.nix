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
        opencl.enable = true;
        overdrive.enable = true;
    };

    environment.systemPackages = with pkgs.rocmPackages; [
        rocminfo
        rocmlir
        mpi
        rpp
        clr
        hipcc
        hiprt
    ];

    systemd.tmpfiles.rules = 
    let
        rocmEnv = pkgs.symlinkJoin {
            name = "rocm-combined";
            paths = with pkgs.rocmPackages; [
                rocblas
                    hipblas
                    clr
            ];
        };
    in [
        "L+    /opt/rocm   -    -    -     -    ${rocmEnv}"
    ];
}
