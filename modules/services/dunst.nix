{
  lib,
  config,
  pkgs,
  ...
}:
let
  c = config.cfg.meta.colors;
  urgencyBase = {
    background = c.base00;
    foreground = c.base05;
  };
in
{
  hj = {
    packages = with pkgs; [
      libnotify # for notify-send
      dunst
    ];

    xdg.config.files."dunst/dunstrc" = {
      generator = lib.generators.toINI {
        mkKeyValue =
          key: value:
          let
            value' = if lib.isString value then ''"${value}"'' else toString value;
          in
          "${key}=${value'}";
      };
      value = {
        global = {
          width = 300;
          height = 300;
          offset = "10x15";
          origin = "top-right";
          frame_color = c.base0B;
          frame_width = 1;
          notification_limit = 3;
          mouse_left_click = "do_action, close_current";
          mouse_middle_click = "close_all";
          mouse_right_click = "close_current";
        };

        urgency_low = urgencyBase // {
          timeout = 5;
        };

        urgency_normal = urgencyBase // {
          timeout = 10;
        };

        urgency_critical = urgencyBase // {
          timeout = 0;
          frame_color = c.base08;
          highlight = c.base08;
        };
      };
    };

    systemd.services.dunst = {
      description = "Dunst notification service";
      after = [ "graphical-session.target" ];
      partOf = [ "graphical-session.target" ];
      serviceConfig = {
        Type = "dbus";
        BusName = "org.freedesktop.Notifications";
        ExecStart = lib.getExe pkgs.dunst;
      };
      restartTriggers = [
        config.hj.xdg.config.files."dunst/dunstrc".source
      ];
    };
  };
}
