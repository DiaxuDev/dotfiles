{ pkgs, inputs, ... }:
{
  imports = [
    ./shell
    ./btop.nix
    ./git.nix
    ./kitty.nix
    ./tealdeer.nix
    ./television.nix
  ];

  home.packages = with pkgs; [
    file # wdym it's not installed by default
    jq
    ripgrep
    fd
    inputs.self.packages.${pkgs.stdenv.hostPlatform.system}.lyrecho
  ];

  programs.zoxide.enable = true;
  programs.eza.enable = true;
  programs.bat.enable = true;
}
