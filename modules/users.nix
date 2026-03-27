{ config, pkgs, ... }:

{
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
}
