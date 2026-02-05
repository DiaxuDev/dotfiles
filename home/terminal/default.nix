{ pkgs, ... }:
{
  imports = [
    ./shell
    ./btop.nix
    ./git.nix
    ./kitty.nix
  ];

  home.packages = with pkgs; [
    file # wdym it's not installed by default
  ];

  programs.zoxide.enable = true;
  programs.eza.enable = true;
  programs.bat.enable = true;
}
