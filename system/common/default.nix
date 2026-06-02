{ pkgs, ... }:
{
  imports = [
    ./boot.nix
    ./connectivity.nix
    ./fonts.nix
    ./hjem.nix
    ./hyprland.nix
    ./keyrings.nix
    ./locale.nix
    ./nix.nix
    ./printing.nix
    ./sddm.nix
    ./sound.nix
    ./steam.nix
    ./thunar.nix
    ./users.nix
    ./virtualization.nix
    ./zsh.nix
  ];

  time.timeZone = "Europe/Warsaw";

  services.flatpak.enable = true; # It's needed for boblox :(
  programs.dconf.enable = true;

  environment.systemPackages = with pkgs; [
    vim
    prismlauncher
    gpu-screen-recorder
  ];

  programs.gpu-screen-recorder.enable = true;
  programs.localsend.enable = true;

  # It's here so that you don't wake up to 20 config errors after an update
  system.stateVersion = "25.11";
}
