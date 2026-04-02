{ pkgs, ... }:
{
  home.packages = [ pkgs.grimblast ];

  programs.satty = {
    enable = true;

    settings.general = {
      early-exit = true;
      copy-command = "wl-copy"; # needed for wl-clip-persist to work with early-exit
      default-hide-toolbars = true;
    };
  };

  wayland.windowManager.hyprland.settings = {
    windowrule = [ "match:class com.gabm.satty, float on, stay_focused on" ];
  };
}
