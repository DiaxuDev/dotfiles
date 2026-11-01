{
  imports = [
    ./config.nix
    ./cursor.nix
  ];

  programs.hyprland.enable = true;
  environment.variables.NIXOS_OZONE_WL = "1";
  services.displayManager.defaultSession = "hyprland";
}
