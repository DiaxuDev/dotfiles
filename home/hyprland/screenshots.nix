{ pkgs, ... }:
{
  programs.satty.enable = true;
  home.packages = [ pkgs.grim ];
}
