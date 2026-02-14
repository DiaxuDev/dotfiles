{ pkgs, ... }:
{
  imports = [
    ./discord
    ./zen
    ./calculator.nix
    ./thunderbird.nix
    ./zed.nix
  ];

  home.packages = with pkgs; [
    spotify
  ];
}
