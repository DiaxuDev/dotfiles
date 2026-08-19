{
  lib,
  lib',
  pkgs,
  config,
  ...
}:
{
  hj = {
    packages = [ pkgs.swayosd ];

    xdg.config.files."swayosd/config.toml" = {
      generator = (pkgs.formats.toml { }).generate "config.toml";
      value = {
        server.show_percentage = true;
      };
    };

    systemd.services.swayosd = lib'.mkGraphicalService {
      description = "SwayOSD daemon";
      serviceConfig = {
        Type = "simple";
        Restart = "always";
        ExecStart = lib.getExe' pkgs.swayosd "swayosd-server";
      };
    };

  };

  cfg.hyprland.binds = [
    {
      key = "XF86AudioRaiseVolume";
      exec = ''hl.dsp.exec_raw("swayosd-client --output-volume raise")'';
      flags = [ "repeating" ];
    }
    {
      key = "XF86AudioLowerVolume";
      exec = ''hl.dsp.exec_raw("swayosd-client --output-volume lower")'';
      flags = [ "repeating" ];
    }
    {
      key = "XF86AudioMute";
      exec = ''hl.dsp.exec_raw("swayosd-client --output-volume mute-toggle")'';
    }
    {
      key = "XF86AudioPlay";
      exec = ''hl.dsp.exec_raw("swayosd-client --playerctl play-pause")'';
    }
  ]
  ++ lib.optionals config.cfg.meta.isLaptop [
    {
      key = "XF86AudioMicMute";
      exec = ''hl.dsp.exec_raw("swayosd-client --input-volume mute-toggle")'';
    }
    {
      key = "XF86MonBrightnessUp";
      exec = ''hl.dsp.exec_raw("swayosd-client --brightness +10")'';
    }
    {
      key = "XF86MonBrightnessDown";
      exec = ''hl.dsp.exec_raw("swayosd-client --brightness -10")'';
    }
  ];
}
