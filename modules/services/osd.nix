{
  lib,
  pkgs,
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

    systemd.services.swayosd = {
      description = "SwayOSD daemon";
      after = [ "graphical-session.target" ];
      wantedBy = [ "graphical-session.target" ];
      partOf = [ "graphical-session.target" ];
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
  ];
}
