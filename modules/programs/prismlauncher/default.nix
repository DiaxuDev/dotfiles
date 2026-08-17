{
  lib,
  pkgs,
  config,
  ...
}:
let
  inherit (lib) mkEnableOption mkIf;

  cfg = config.cfg.programs.prismlauncher;
in
{
  options.cfg.programs.prismlauncher = {
    enable = mkEnableOption "prismlauncher";
  };

  config = mkIf cfg.enable {
    hj.packages = [ pkgs.prismlauncher ];
  };
}
