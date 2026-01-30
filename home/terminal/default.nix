{ pkgs, ... }:
{
  imports = [
    ./shell
    ./git.nix
    ./kitty.nix
  ];

  home.packages = with pkgs; [
    file # wdym it's not installed by default
  ];
}
