{
  lib,
  pkgs,
  config,
  ...
}:
{
  hj = {
    xdg.config.files."hypr/hyprpaper.conf".text = ''
      wallpaper {
         monitor=
         path=~/Pictures/snow_runner.png
      }
      splash=true
      splash_offset=40
      splash_opacity=1
    '';

    systemd.services.hyprpaper = {
      description = "Wallpaper service for Hyprland";
      after = [ "graphical-session.target" ];
      wantedBy = [ "graphical-session.target" ];
      partOf = [ "graphical-session.target" ];
      serviceConfig = {
        Type = "simple";
        Restart = "always";
        ExecStart = "${lib.getExe pkgs.hyprpaper}";
      };
      restartTriggers = [
        config.hj.xdg.config.files."hypr/hyprpaper.conf".source
      ];
    };
  };

  cfg.hyprland.settings = {
    misc = {
      disable_hyprland_logo = true; # disable the default background
      disable_splash_rendering = true; # disable default splash rendering
    };
  };
}
