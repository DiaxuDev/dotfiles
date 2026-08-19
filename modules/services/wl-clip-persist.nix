{
  lib,
  lib',
  pkgs,
  ...
}:
{
  hj.systemd.services.wl-clip-persist = lib'.mkGraphicalService {
    description = "Clipboard persistence service";
    serviceConfig = {
      Type = "simple";
      ExecStart = "${lib.getExe pkgs.wl-clip-persist} --clipboard regular";
      Restart = "always";
    };
  };
}
