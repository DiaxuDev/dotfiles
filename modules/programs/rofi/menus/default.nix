{
  config,
  lib,
  pkgs,
  ...
}:
let
  themePath = "${config.hj.xdg.config.directory}/rofi/menu.rasi";

  rofiCmd =
    mesg: cols:
    ''rofi -dmenu -mesg "${mesg}" -theme-str 'listview {columns: ${toString cols}; lines: 1;}' -theme ${themePath}'';

  callMenu = lib.callPackageWith (pkgs // { inherit rofiCmd; });

  power = callMenu ./power.nix { };
  screenshot = callMenu ./screenshot.nix { borderColor = config.cfg.meta.colors.base0B; };
  wallpapers = callMenu ./wallpapers.nix { };
in
{
  cfg.hyprland.binds = [
    {
      key = "SUPER + escape";
      exec = ''hl.dsp.exec_raw("${lib.getExe power}")'';
    }
    {
      key = "print";
      exec = ''hl.dsp.exec_raw("${lib.getExe screenshot} copy")'';
    }
    {
      key = "SHIFT+print";
      exec = ''hl.dsp.exec_raw("${lib.getExe screenshot} edit")'';
    }
  ];

  hj.packages = [
    (pkgs.makeDesktopItem {
      name = "change-wallpaper";
      desktopName = "Change wallpaper";
      comment = "Open wallpaper picker";
      icon = "preferences-desktop-wallpaper";
      categories = [ "Settings" ];
      keywords = [
        "background"
        "wallpaper"
      ];
      exec = lib.getExe wallpapers;
    })
  ];
}
