{
  pkgs,
  lib,
  config,
  ...
}:
{
  imports = [
    ./theme.nix
  ];

  programs.rofi = {
    enable = true;

    theme = "theme";
    extraConfig = {
      case-sensitive = false;
      cycle = true;
      show-icons = true;
      font = "JetBrainsMono Nerd Font 10";
    };
  };

  wayland.windowManager.hyprland.settings = {
    bind =
      let
        callMenu =
          path:
          lib.getExe (
            import path {
              inherit pkgs;
              theme = "${config.xdg.configHome}/rofi/menu.rasi";
              genList = cols: "'listview {columns: ${toString cols}; lines: 1;}'";
            }
          );
      in
      [
        "SUPER, r, exec, rofi -show drun"
        "SUPER, escape, exec, ${callMenu ./power.nix}"
        ", print, exec, ${callMenu ./screenshot.nix}"
      ];
  };
}
