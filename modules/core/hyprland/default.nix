{
  imports = [
    ./config.nix
    ./cursor.nix
  ];

  programs.hyprland.enable = true;
  environment.variables.NIXOS_OZONE_WL = "1";
  services.displayManager.defaultSession = "hyprland";

  hj.systemd.targets.hyprland-session = {
    description = "Hyprland compositor session";
    bindsTo = [ "graphical-session.target" ];
    wants = [ "graphical-session-pre.target" ];
    after = [ "graphical-session-pre.target" ];
  };
}
