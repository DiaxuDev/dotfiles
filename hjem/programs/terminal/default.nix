{ inputs, pkgs, ... }:
{
  imports = [
    ./television
    ./zsh
    ./btop.nix
    ./direnv.nix
    ./git.nix
    ./starship.nix
    ./tealdeer.nix
    ./zoxide.nix
  ];

  hj.packages = with pkgs; [
    file # wdym it's not installed by default
    jq
    ripgrep
    fd
    bat
    eza
    inputs.self.packages.${pkgs.stdenv.hostPlatform.system}.lyrecho
  ];
}
