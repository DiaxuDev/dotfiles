{
  lib,
  pkgs,
  config,
  ...
}:
let
  inherit (lib) mkEnableOption mkIf;

  cfg = config.cfg.programs.steam;
in
{
  options.cfg.programs.steam = {
    enable = mkEnableOption "steam";
  };

  config = mkIf cfg.enable {
    programs = {
      steam = {
        enable = true;
        extraCompatPackages = with pkgs; [
          proton-ge-bin
        ];
      };

      gamemode = {
        enable = true;
        enableRenice = true;
        settings.general = {
          renice = 15;
          softrealtime = "auto";
        };
      };
    };
  };

}
