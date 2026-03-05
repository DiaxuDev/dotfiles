{ config, pkgs, ... }:
let
  c = config.modules.colors;

  urgencyBase = {
    background = c.base00;
    foreground = c.base05;
  };
in
{
  services.dunst = {
    enable = true;
    iconTheme = config.gtk.iconTheme;

    settings = {
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

  home.packages = with pkgs; [ libnotify ]; # for notify-send
}
