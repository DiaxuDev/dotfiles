{ lib', pkgs, ... }:
{
  systemd.user.services.polkit-gnome-authentication-agent-1 = lib'.mkGraphicalService {
    description = "polkit-gnome-authentication-agent-1";
    serviceConfig = {
      Type = "simple";
      ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
      Restart = "on-failure";
      RestartSec = 1;
      TimeoutStopSec = 10;
    };
  };
}
