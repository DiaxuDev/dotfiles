{ pkgs, ... }:
{
  hj = {
    packages = [ pkgs.satty ];

    xdg.config.files."satty/config.toml" = {
      generator = (pkgs.formats.toml { }).generate "config.toml";
      value = {
        general = {
          early-exit = true;
          copy-command = "wl-copy"; # needed for wl-clip-persist to work with early-exit
          default-hide-toolbars = true;
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
