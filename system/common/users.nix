{ pkgs, ... }:
{
  users.users.diaxudev = {
    isNormalUser = true;
    extraGroups = [
      "wheel"
      "networkmanager"
      "libvirtd"
    ];

    shell = pkgs.zsh;
  };
}
