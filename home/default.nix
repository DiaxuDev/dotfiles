{ ... }:
{
  imports = [
    ./hyprland
    ./programs
    ./terminal
    ./style.nix
  ];

  home = {
    username = "diaxudev";
    homeDirectory = "/home/diaxudev";

    stateVersion = "25.11";
  };
}
