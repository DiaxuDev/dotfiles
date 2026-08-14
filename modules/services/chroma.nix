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
        ExecReload = "${lib.getExe' pkgs.coreutils "kill"} -SIGHUP $MAINPID";
      };
      reloadTriggers = [
        config.hj.xdg.config.files."chroma/chroma.toml".source
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
                netcat
                jq
                hyprland
              ];
              text = ''
                monitor=$(hyprctl monitors -j | jq 'first(.[] | select(.focused)).name' -r)
                current=$(echo "get $monitor" | nc -U /tmp/chroma.sock)

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

                echo "set $monitor ~/.local/share/wallpapers/$new" | nc -U /tmp/chroma.sock
              '';
            };
          in
          ''hl.dsp.exec_raw("${lib.getExe script}")'';
      }
    ];
  };
}
