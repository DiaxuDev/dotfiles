{ lib, pkgs, ... }:
{
  hj = {
    packages = [ pkgs.satty ];

    xdg.config.files."satty/config.toml" = {
      generator = (pkgs.formats.toml { }).generate "config.toml";
      value = {
        general = {
          early-exit = true;
          copy-command = "${lib.getExe' pkgs.wl-clipboard "wl-copy"}";
        };
      };
    };
  };

  cfg.hyprland.windowRules = [
    {
      match.class = "com.gabm.satty";
      float = true;
      stay_focused = true;
    }
  ];
}
