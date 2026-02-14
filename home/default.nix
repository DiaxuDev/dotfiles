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

  nixpkgs.config.allowUnfree = true; # TODO: switch to home-manager nixos module so this won't be needed anymore
}
