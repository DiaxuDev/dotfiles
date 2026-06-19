{
  config,
  lib,
  pkgs,
  ...
}:
{
  hj = {
    xdg.config.files."waybar/config" = {
      generator = lib.generators.toJSON { };
      value = {
        layer = "bottom";
        position = "bottom";

        modules-left = [
          "hyprland/workspaces"
          "hyprland/window"
        ];
        modules-center = [ ];
        modules-right = [
          "cpu"
          "custom/label-cpu"
          "memory"
          "custom/label-mem"
          "tray"
          "clock"
        ];

        "hyprland/workspaces" = {
          format = "{name}";
          on-scroll-up = "hyprctl dispatch 'hl.dsp.focus({ workspace = \"e+1\" })'";
          on-scroll-down = "hyprctl dispatch 'hl.dsp.focus({ workspace = \"e-1\" })'";
        };

        "hyprland/window" = {
          max-length = 40;
        };

        "cpu" = {
          interval = 5;
          format = "{usage:2}%";
        };

        "custom/label-cpu" = {
          format = "CPU";
          tooltip = false;
        };

        "memory" = {
          interval = 5;
          format = "{}%";
        };

        "custom/label-mem" = {
          format = "MEM";
          tooltip = false;
        };

        "tray" = {
          spacing = 12;
        };

        "clock" = {
          interval = 60;
          format = "{:%Y-%m-%d %H:%M}";
        };
      };
    };

    xdg.config.files."waybar/style.css".text =
      let
        c = config.cfg.meta.colors;
      in
      ''
        * {
          border: none;
          border-radius: 0;
          font-size: 14px;
          font-family: 'JetBrainsMono NF';
          min-height: 0;
          margin: 0 4px;
          padding: 0;
        }

        window#waybar {
          background-color: ${c.base00};
          border-radius: 0px;
          color: ${c.base05};
        }

        window#waybar>box {
          margin-top: 4px;
          margin-bottom: 4px;
        }

        #workspaces {
          border: 0px;
          font-style: normal;
        }

        #workspaces button {
          color: ${c.base0B};
          border-radius: 0;
        }

        #workspaces button:hover {
          color: ${c.base0C};
          border: 0px solid transparent;
        }

        #workspaces button.active {
          border: 1px solid ${c.base0B};
        }

        tooltip {
          border-radius: 10px;
        }

        #cpu, #memory {
          margin: 0;
          padding: 0;
          color: ${c.base0B};
        }

        #custom-label-cpu, #custom-label-mem {
          margin-right: 12px;
        }
      '';

    systemd.services.waybar = {
      description = "Waybar bar";
      after = [ "graphical-session.target" ];
      wantedBy = [ "graphical-session.target" ];
      partOf = [ "graphical-session.target" ];
      serviceConfig = {
        Type = "simple";
        Restart = "always";
        ExecStart = "${lib.getExe pkgs.waybar}";
      };
      path = [ pkgs.hyprland ];
      restartTriggers = [
        config.hj.xdg.config.files."waybar/config".source
        config.hj.xdg.config.files."waybar/style.css".source
      ];
    };

  };
}
