{ config, lib, ... }:
let
  inherit (lib.strings) removePrefix;
  c = config.modules.colors;
in
{
  imports = [
    ./rofi.nix
  ];

  wayland.windowManager.hyprland = {
    enable = true;
    # Both are managed by system-wide programs.hyprland option
    package = null;
    portalPackage = null;

    settings = {
      input.kb_layout = "pl";

      env = [
        "XDG_DATA_DIRS,$XDG_DATA_DIRS:/usr/share:/var/lib/flatpak/exports/share:$HOME/.local/share/flatpak/exports/share"
      ];

      general = {
        gaps_in = 0;
        gaps_out = 0;

        border_size = 1;
        "col.inactive_border" = "rgb(${removePrefix "#" c.base03})";
        "col.active_border" = "rgb(${removePrefix "#" c.base0B})";
      };

      animations.enabled = false;

      bind = [
        "SUPER, return, exec, kitty"
        "SUPER, r, exec, rofi -show drun"
        "SUPER, q, killactive"

        "SUPER, left, movefocus, l"
        "SUPER, right, movefocus, r"
        "SUPER, up, movefocus, u"
        "SUPER, down, movefocus, b"

        "SUPER, 1, workspace, 1"
        "SUPER, 2, workspace, 2"
        "SUPER, 3, workspace, 3"
        "SUPER, 4, workspace, 4"
        "SUPER, 5, workspace, 5"
        "SUPER, 6, workspace, 6"
        "SUPER, 7, workspace, 7"
        "SUPER, 8, workspace, 8"
        "SUPER, 9, workspace, 9"

        "SUPER SHIFT, 1, movetoworkspace, 1"
        "SUPER SHIFT, 2, movetoworkspace, 2"
        "SUPER SHIFT, 3, movetoworkspace, 3"
        "SUPER SHIFT, 4, movetoworkspace, 4"
        "SUPER SHIFT, 5, movetoworkspace, 5"
        "SUPER SHIFT, 6, movetoworkspace, 6"
        "SUPER SHIFT, 7, movetoworkspace, 7"
        "SUPER SHIFT, 8, movetoworkspace, 8"
        "SUPER SHIFT, 9, movetoworkspace, 9"
      ];
    };
  };
}
