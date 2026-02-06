{ pkgs, ... }:
{
  # calc is slang for calculator btw
  home.packages = with pkgs; [
    libqalculate
    qalculate-qt
  ];

  wayland.windowManager.hyprland.settings = {
    bind = [ ",XF86Calculator, exec, qalculate-qt" ];
  };
}
