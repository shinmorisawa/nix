{ config, pkgs, ... }:

{
    time.timeZone = "Asia/Tokyo";
    i18n.defaultLocale = "en_US.UTF-8";
    home-manager.backupFileExtension = "bak";
}
