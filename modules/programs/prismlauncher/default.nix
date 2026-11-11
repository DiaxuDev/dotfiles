{
  lib,
  inputs',
  pkgs,
  config,
  ...
}:
let
  inherit (lib) mkEnableOption mkIf;

  theme = inputs'.self.packages.ore-ui;

  cfg = config.cfg.programs.prismlauncher;
in
{
  options.cfg.programs.prismlauncher = {
    enable = mkEnableOption "prismlauncher";
  };

  config = mkIf cfg.enable {
    hj = {
      packages = [ pkgs.prismlauncher ];

      xdg.data.files = {
        "PrismLauncher/themes/${theme.themeName}".source =
          "${theme}/share/PrismLauncher/themes/${theme.themeName}";
        "PrismLauncher/iconthemes/${theme.iconThemeName}".source =
          "${theme}/share/PrismLauncher/iconthemes/${theme.iconThemeName}";
      };
    };

    # Required for Ore UI theme
    fonts.packages = [ pkgs.monocraft ];
  };
}
