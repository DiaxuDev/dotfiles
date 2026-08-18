{
  lib,
  pkgs,
  config,
  ...
}:
{
  hj = {
    xdg.config.files."wpaperd/config.toml" = {
      generator = (pkgs.formats.toml { }).generate "config.toml";
      value = {
        default = {
          path = "~/.local/state/wallpaper";
          transition-time = 800;
          transition.directional-scaled = { };
        };
      };
    };

    systemd.services.wpaperd = {
      description = "Wallpaper service for Wayland";
      after = [ "graphical-session.target" ];
      wantedBy = [ "graphical-session.target" ];
      partOf = [ "graphical-session.target" ];
      serviceConfig = {
        Type = "simple";
        Restart = "always";
        ExecStart = lib.getExe pkgs.wpaperd;
      };
      restartTriggers = [
        config.hj.xdg.config.files."wpaperd/config.toml".source
      ];
    };
  };

  cfg.hyprland = {
    settings.misc = {
      disable_hyprland_logo = true; # disable the default background
      disable_splash_rendering = true; # disable default splash rendering
    };

    binds = [
      {
        key = "SUPER + F8";
        exec =
          let
            script = pkgs.writeShellApplication {
              name = "toggle-wallpaper";
              runtimeInputs = with pkgs; [
                hyprland
                jq
                wpaperd
              ];
              text = ''
                monitor=$(hyprctl monitors -j | jq 'first(.[] | select(.focused)).name' -r)
                current=$(wpaperctl get "$monitor")

                case $(basename "$(readlink -f "$current")") in
                    "diaxuchan.png")
                        new="diaxuchan_alt.png"
                        ;;
                    "diaxuchan_alt.png")
                        new="diaxuchan.png"
                        ;;
                    *)
                        exit 0
                        ;;
                esac

                wpaperctl set "$HOME/.local/share/wallpapers/$new"
              '';
            };
          in
          ''hl.dsp.exec_raw("${lib.getExe script}")'';
      }
    ];
  };
}
