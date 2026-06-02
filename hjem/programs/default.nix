{ pkgs, ... }:
{
  imports = [
    ./discord
    ./rofi
    ./terminal
    ./zen
    ./calculator.nix
    ./kitty.nix
    ./satty.nix
    ./thunderbird.nix
    ./zed.nix
  ];

  hj.packages = with pkgs; [
    spotify
    imv
    mpv
  ];
}
