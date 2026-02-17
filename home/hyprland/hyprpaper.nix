{
  services.hyprpaper = {
    enable = true;
    settings = {
      splash = true;
      splash_opacity = 1;
      splash_offset = 40;

      wallpaper = [
        {
          monitor = "";
          path = "~/Pictures/snow_runner.png"; # TODO: move this into nix store
        }
      ];
    };
  };

  wayland.windowManager.hyprland.settings = {
    misc = {
      disable_hyprland_logo = true; # disable the default background
      disable_splash_rendering = true; # disable default splash rendering
    };
  };
}
