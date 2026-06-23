{ config, pkgs, ... }:

let
    anime4k = pkgs.callPackage ../../packages/anime4k.nix {};
in 
{
    programs.mpv = {
        enable = true;
        package = (pkgs.mpv.override {
            scripts = with pkgs.mpvScripts; [
                modernx
                thumbfast
            ];
        });
        config = {
            profile = "high-quality";
            vo = "gpu";
            scale-antiring = 0.6;
            interpolation = true;
            target-peak = 203;
            dither-depth = 8;
            keep-open = "yes";
            save-position-on-quit = "yes";
            alang = "jpn,ja";
            osc = false;
            border = false;
            cache = true;
            cache-secs = 600;
            cache-pause = false;
            demuxer-cache-duration = 600;
            demuxer-max-bytes = "16GiB";
            read-cache-secs = 600;
            glsl-shaders = "${anime4k}/share/anime4k/Restore/Anime4K_Clamp_Highlights.glsl:${anime4k}/share/anime4k/Restore/Anime4K_Restore_CNN_UL.glsl:${anime4k}/share/anime4k/Upscale/Anime4K_Upscale_CNN_x2_UL.glsl";
        };
    };
}
