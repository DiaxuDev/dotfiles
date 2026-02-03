{ pkgs, ... }:
{
  programs.hyprland.enable = true;
  services.displayManager.sddm.enable = true;
  services.displayManager.sddm.wayland.enable = true;
  environment.variables.NIXOS_OZONE_WL = "1";

  systemd.user.services.polkit-gnome-authentication-agent-1 = {
    description = "polkit-gnome-authentication-agent-1";
    wantedBy = [ "graphical-session.target" ];
    wants = [ "graphical-session.target" ];
    after = [ "graphical-session.target" ];
    serviceConfig = {
      Type = "simple";
      ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
      Restart = "on-failure";
      RestartSec = 1;
      TimeoutStopSec = 10;
    };
  };
}
