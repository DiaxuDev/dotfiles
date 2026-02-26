{ config, lib, ... }:
let
  c = config.modules.colors;

  hc = color: "rgb(${lib.removePrefix "#" color})";
in
{
  programs.hyprlock = {
    enable = true;

    settings = {
      general = {
        hide_cursor = true;
      };

      background.path = "~/Pictures/snow_runner.png"; # TODO: move this into nix store

      label = [
        # DATE
        {
          monitor = "";
          text = "cmd[update:43200000] date '+%A, %b %d'";
          color = hc c.base0B;
          font_size = 22;
          font_family = "JetBrainsMono NF";
          position = "-4%, 15%";
          halign = "right";
          valign = "bottom";
        }

        # TIME
        {
          monitor = "";
          text = "cmd[update:60000] date '+%H:%M'";
          color = hc c.base0B;
          font_size = 65;
          font_family = "JetBrainsMono NF";
          position = "-4%, 5%";
          halign = "right";
          valign = "bottom";
        }

        # WELCOME
        {
          monitor = "";
          text = "Welcome, $USER";
          color = hc c.base0B;
          font_size = 20;
          font_family = "JetBrainsMono NF";
          position = "11.5%, 14.3%";
          halign = "left";
          valign = "bottom";
        }
      ];

      input-field = {
        monitor = "";
        size = "300, 60";
        outline_thickness = 2;
        dots_size = 0.1;
        dots_spacing = 0.3;
        dots_center = false;
        inner_color = hc c.base00;
        font_color = hc c.base06;
        fade_on_empty = false;
        placeholder_text = "Enter password...";
        hide_input = false;
        check_color = hc c.base0B;
        fail_color = hc c.base0F;
        fail_text = "Authentication failed...";
        position = "11.5%, 7.5%";
        halign = "left";
        valign = "bottom";
        font_family = "JetBrainsMono NF";
        font_size = 18;
      };

      image = {
        monitor = "";
        path = "~/.face.icon";
        size = 113;
        border_size = 0;
        position = "4%, 7.5%";
        halign = "left";
        valign = "bottom";
      };
    };
  };
}
