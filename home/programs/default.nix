{ ... }:
{
  imports = [
    ./zed.nix
  ];

  programs.vesktop.enable = true;
  programs.firefox.enable = true;
}
