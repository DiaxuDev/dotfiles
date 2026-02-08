{ pkgs, ... }:
{
  imports = [
    ./boot.nix
    ./connectivity.nix
    ./fonts.nix
    ./hyprland.nix
    ./keyrings.nix
    ./nix.nix
    ./sound.nix
    ./steam.nix
    ./users.nix
    ./zsh.nix
  ];

  time.timeZone = "Europe/Warsaw";

  services.flatpak.enable = true; # It's needed for boblox :(
  programs.dconf.enable = true;

  environment.systemPackages = with pkgs; [
    vim
    prismlauncher
    home-manager
  ];

  # It's here so that you don't wake up to 20 config errors after an update
  system.stateVersion = "25.11";
}
