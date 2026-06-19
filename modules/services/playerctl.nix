{ lib, pkgs, ... }:
{
  hj = {
    packages = [ pkgs.playerctl ];

    systemd.services.playerctld = {
      description = "MPRIS media service";
      serviceConfig = {
        Type = "dbus";
        BusName = "org.mpris.MediaPlayer2.playerctld";
        ExecStart = lib.getExe' pkgs.playerctl "playerctld";
      };
      wantedBy = [ "default.target" ];
    };
  };
}
