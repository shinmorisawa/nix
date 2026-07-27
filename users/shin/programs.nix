{ config, pkgs, ... }:

{
    programs.vesktop = {
        enable = true;
        package = pkgs.vesktop;
        settings = {
            arRPC = true;
            minimizeToTray = false;
            hardwareAcceleration = true;
            discordBranch = "canary";
        };

        vencord = {
            settings = {
                plugins = {
                    FakeNitro = {
                        enabled = true;
                    };
                };
                useQuickCss = true;
            };
            extraQuickCss = ''
                :root {
                    --font-primary: "JetBrainsMono Nerd Font", sans-serif;
                    --font-display: "JetBrainsMono Nerd Font", sans-serif;
                    --font-headline: "JetBrainsMono Nerd Font", sans-serif;
                    --font-code: "JetBrainsMono Nerd Font", monospace;
                }
            '';
        };
    };

    programs.cava = {
        enable = true;
        settings = {
            general.framerate = 165;
            general.bar_width = 3;
            general.bar_spacing = 0;
            input.method = "pipewire";
            output = {
                channels = "mono";
                mono_option = "average";
            };
            smoothing.noise_reduction = 20;
        };
    };

    programs.librewolf = {
        enable = true;
        settings = {
            "webgl.disabled" = false;
        };
    };

    programs.git = {
        enable = true;
        settings = {
            user.name = "Shin Morisawa";
            user.email = "git@tryh4rd.dev";
            commit.gpgSign = true;
        };     

        signing = {
            key = "8B8F8551938A9A71";
            signByDefault = true;
        };
    };
}
