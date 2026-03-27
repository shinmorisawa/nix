{ config, pkgs, ... }:

{
    networking.hostName = "deathstar";
    networking.networkmanager.enable = true;
}
