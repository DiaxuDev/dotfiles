{
  inputs,
  lib,
  pkgs,
  config,
  ...
}:
{
  hj = {
    xdg.config.files."chroma/chroma.toml" = {
      generator = (pkgs.formats.toml { }).generate "chroma.toml";
      value = {
        default_image = "~/.local/state/wallpaper";
        max_output_width = 1920;
        max_output_height = 1080;
        transition = {
          enable = true;
          duration_ms = 300;
        };
        animation.enable = false;
        ipc = {
          enable = true;
          socket_path = "/tmp/chroma.sock";
        };
      };
    };

    systemd.services.chroma = {
      description = "Wallpaper service for Wayland";
      after = [ "graphical-session.target" ];
      wantedBy = [ "graphical-session.target" ];
      partOf = [ "graphical-session.target" ];
      serviceConfig = {
        Type = "simple";
        Restart = "always";
        ExecStart = lib.getExe inputs.self.packages.${pkgs.stdenv.hostPlatform.system}.chroma;
        ExecReload = "kill -HUP $MAINPID";
      };
      reloadTriggers = [
        config.hj.xdg.config.files."chroma/chroma.toml".source
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
