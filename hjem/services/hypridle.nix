{
  config,
  lib,
  pkgs,
  ...
}:
{
  hj = {
    xdg.config.files."hypr/hypridle.conf".text = ''
      general {
        lock_cmd = pidof hyprlock || hyprlock
        before_sleep_cmd = loginctl lock-session
        after_sleep_cmd = hyprctl dispatch hl.dsp.dpms({ action = "enable" })
      }
    '';

    systemd.services.hypridle = {
      description = "Hypridle service";
      after = [ "graphical-session.target" ];
      wantedBy = [ "graphical-session.target" ];
      partOf = [ "graphical-session.target" ];
      serviceConfig = {
        Type = "simple";
        Restart = "always";
        ExecStart = lib.getExe pkgs.hypridle;
      };
      path = with pkgs; [
        hyprland
        hyprlock
        procps
      ];
      restartTriggers = [
        config.hj.xdg.config.files."hypr/hypridle.conf".source
      ];
    };
  };
}
