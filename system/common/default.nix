{ pkgs, ... }:
{
  imports = [
    ./boot.nix
    ./connectivity.nix
    ./hyprland.nix
    ./nix.nix
    ./sound.nix
    ./users.nix
  ];

  time.timeZone = "Europe/Warsaw";

  # It's needed for boblox :(
  services.flatpak.enable = true;

  environment.systemPackages = with pkgs; [
    vim
    home-manager
  ];

  # It's here so that you don't wake up to 20 config errors after an update
  system.stateVersion = "25.11";
}
