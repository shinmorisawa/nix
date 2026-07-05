{ pkgs, ... }:

{
    security.rtkit.enable = true;

    security.pam.loginLimits = [
        { domain = "@wheel"; type = "-"; item = "rtprio"; value = "95"; }
        { domain = "@wheel"; type = "-"; item = "nice"; value = "-20"; }
        { domain = "@wheel"; type = "-"; item = "memlock"; value = "unlimited"; };
    ];

    programs.gamemode = {
        enable = true;
        settings = {
            general = {
                renice = 0;
            };
        };
    };
}
