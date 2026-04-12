{ config, pkgs, ... }:

{
    xdg.portal = {
        enable = true;
        wlr.enable = true;
        configPackages = with pkgs; [ xdg-desktop-portal-gtk xdg-desktop-portal-wlr ];
        config = {
            common = {
                default = "wlr";
            };
        };
    };
}
