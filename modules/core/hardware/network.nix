{ config, ... }:
{
  networking.networkmanager.enable = true;

  users.users.${config.cfg.meta.username}.extraGroups = [ "networkmanager" ];
}
