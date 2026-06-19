{ lib, config, ... }:
let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.cfg.hardware.nvidia;
in
{
  options.cfg.hardware.nvidia.enable = mkEnableOption "nvidia";

  config = mkIf cfg.enable {
    hardware = {
      graphics.enable = true;
      nvidia = {
        open = true;
        powerManagement.enable = true;
        nvidiaSettings = false;
      };
    };

    services.xserver.videoDrivers = [ "nvidia" ];
  };
}
