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

  callMenu = path: lib.getExe (import path { inherit pkgs rofiCmd; });

  power = callMenu ./power.nix;
  screenshot = callMenu ./screenshot.nix;
  wallpapers = callMenu ./wallpapers.nix;
in
{
  cfg.hyprland.binds = [
    {
      key = "SUPER + escape";
      exec = ''hl.dsp.exec_raw("${power}")'';
    }
    {
      key = "print";
      exec = ''hl.dsp.exec_raw("${screenshot} copy")'';
    }
    {
      key = "SHIFT+print";
      exec = ''hl.dsp.exec_raw("${screenshot} edit")'';
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
      exec = wallpapers;
    })
  ];
}
