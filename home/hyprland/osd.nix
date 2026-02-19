{ pkgs, ... }:
let
  toml = pkgs.formats.toml { };
in
{
  services.playerctld.enable = true;
  services.swayosd.enable = true;

  # home-manager doesn't have an option for doing this so we have to do this without abstractions
  xdg.configFile."swayosd/config.toml".source = toml.generate "swayosd-config" {
    server.show_percentage = true;
  };

  wayland.windowManager.hyprland.settings = {
    binde = [
      ", XF86AudioRaiseVolume, exec, swayosd-client --output-volume raise"
      ", XF86AudioLowerVolume, exec, swayosd-client --output-volume lower"
    ];
    bind = [
      ", XF86AudioMute, exec, swayosd-client --output-volume mute-toggle"
      ", XF86AudioPlay, exec, swayosd-client --playerctl play-pause"
    ];
  };
}
