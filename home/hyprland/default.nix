{
  config,
  lib,
  pkgs,
  ...
}:
let
  inherit (lib.strings) removePrefix;
  c = config.modules.colors;

  workspaces = builtins.concatLists (
    builtins.genList (
      x:
      let
        ws = x + 1;
        key = toString (ws - (10 * (ws / 10)));
      in
      [
        "SUPER, ${key}, workspace, ${toString ws}"
        "SUPER SHIFT, ${key}, movetoworkspace, ${toString ws}"
      ]
    ) 10
  );
in
{
  imports = [
    ./rofi
    ./hyprpaper.nix
    ./osd.nix
    ./screenshots.nix
    ./waybar.nix
  ];

  wayland.windowManager.hyprland = {
    enable = true;
    # Both are managed by system-wide programs.hyprland option
    package = null;
    portalPackage = null;

    systemd = {
      enable = true;
      variables = [ "--all" ];
      extraCommands = [ ]; # i prefer my way of handling this
    };

    settings = {
      input = {
        kb_layout = "pl";
        kb_options = "kpdl:dot";
        numlock_by_default = true;
      };

      env = [
        "XDG_DATA_DIRS,$XDG_DATA_DIRS:/usr/share:/var/lib/flatpak/exports/share:$HOME/.local/share/flatpak/exports/share"
      ];

      exec-once = [ "systemctl --user start hyprland-session.target" ];
      exec-shutdown = [ "systemctl --user stop hyprland-session.target" ];

      general = {
        gaps_in = 0;
        gaps_out = 0;

        border_size = 1;
        "col.inactive_border" = "rgb(${removePrefix "#" c.base03})";
        "col.active_border" = "rgb(${removePrefix "#" c.base0B})";
      };

      animations.enabled = false;

      bindm = [
        "SUPER, mouse:272, movewindow"
        "SUPER, mouse:273, resizewindow"
      ];

      bind = [
        "SUPER, return, exec, kitty"
        "SUPER, e, exec, thunar"
        "SUPER, q, killactive"

        "SUPER, left, movefocus, l"
        "SUPER, right, movefocus, r"
        "SUPER, up, movefocus, u"
        "SUPER, down, movefocus, b"
      ]
      ++ workspaces;
    };
  };

  home.packages = with pkgs; [
    wl-clipboard
  ];

  systemd.user.services.wl-clip-persist = {
    Unit = {
      Description = "Persistent clipboard for Wayland";
      PartOf = [ "graphical-session.target" ];
      After = [ "graphical-session.target" ];
    };
    Service = {
      Type = "simple";
      ExecStart = "${lib.getExe pkgs.wl-clip-persist} --clipboard regular";
      Restart = "always";
    };
    Install = {
      WantedBy = [ "graphical-session.target" ];
    };
  };
}
