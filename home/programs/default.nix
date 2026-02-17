{ pkgs, ... }:
{
  imports = [
    ./discord
    ./zen
    ./calculator.nix
    ./media.nix
    ./thunderbird.nix
    ./zed.nix
  ];

  home.packages = with pkgs; [
    spotify
  ];
}
