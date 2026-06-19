{ pkgs, ... }:
{
  imports = [
    ./discord
    ./prismlauncher
    ./rofi
    ./terminal
    ./zen
    ./calculator.nix
    ./kitty.nix
    ./satty.nix
    ./steam.nix
    ./thunar.nix
    ./thunderbird.nix
    ./zed.nix
  ];

  services.flatpak.enable = true; # It's needed for boblox :(
  programs.localsend.enable = true;
  programs.gpu-screen-recorder.enable = true;

  environment.systemPackages = with pkgs; [ vim ];

  hj.packages = with pkgs; [
    spotify
    imv
    mpv
  ];
}
