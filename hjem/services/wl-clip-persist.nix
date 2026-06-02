{lib, pkgs, ...}:
{
  hj.systemd.services.wl-clip-persist = {
    description = "Clipboard persistence service";
    after = ["graphical-session.target"];
    wantedBy = ["graphical-session.target"];
    partOf = ["graphical-session.target"];
    serviceConfig = {
      Type = "simple";
      ExecStart = "${lib.getExe pkgs.wl-clip-persist} --clipboard regular";
      Restart = "always";
    };
  };
}
