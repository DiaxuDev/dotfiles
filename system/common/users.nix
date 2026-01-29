{ pkgs, ... }:
{
  users.users.diaxudev = {
    isNormalUser = true;
    extraGroups = [
      "wheel"
      "networkmanager"
    ];

    shell = pkgs.zsh;
  };
}
