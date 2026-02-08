{
  imports = [
    ./theme.nix
  ];

  programs.rofi = {
    enable = true;

    theme = "theme";
    extraConfig = {
      modi = "drun,run,filebrowser";
      case-sensitive = false;
      cycle = true;
      show-icons = true;
      font = "JetBrainsMono Nerd Font 10";

      display-drun = "  Apps";
      display-run = "  Run";
      display-filebrowser = "  Files";
    };
  };

  wayland.windowManager.hyprland.settings = {
    bind = [ "SUPER, r, exec, rofi -show drun" ];
  };
}
