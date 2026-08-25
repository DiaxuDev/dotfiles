{
  lib,
  pkgs,
  config,
  ...
}:
let
  inherit (lib) mkOption types;

  cfg = config.cfg.gtk;

  Settings = {
    gtk-theme-name = cfg.theme.name;
    gtk-icon-theme-name = cfg.iconTheme.name;
    gtk-application-prefer-dark-theme = true;
    gtk-cursor-theme-name = cfg.cursorTheme.name;
    gtk-cursor-theme-size = cfg.cursorTheme.size;
  };
in
{
  options.cfg.gtk = {
    theme = {
      package = mkOption {
        type = types.package;
        description = "The GTK theme package to use.";
        default = pkgs.colloid-gtk-theme.override {
          themeVariants = [ "green" ];
          tweaks = [
            "gruvbox"
          ];
        };
      };

      name = mkOption {
        type = types.str;
        description = "The GTK theme name to use.";
        default = "Colloid-Green-Dark-Gruvbox";
      };
    };

    iconTheme = {
      package = mkOption {
        type = types.package;
        description = "The GTK icon theme package to use.";
        default = pkgs.papirus-icon-theme;
      };

      name = mkOption {
        type = types.str;
        description = "The GTK icon theme name to use.";
        default = "Papirus-Dark";
      };
    };

    cursorTheme = {
      name = mkOption {
        type = types.str;
        description = "The GTK cursor theme name to use.";
      };
      size = mkOption {
        type = types.int;
        description = "The size of the GTK cursor.";
      };
    };
  };

  config = {
    hj = {
      packages = [
        cfg.theme.package
        cfg.iconTheme.package
      ];

      xdg.config.files = {
        "gtk-3.0/settings.ini" = {
          generator = lib.generators.toINI { };
          value = { inherit Settings; };
        };
        "gtk-4.0/settings.ini" = {
          generator = lib.generators.toINI { };
          value = { inherit Settings; };
        };
        "gtk-4.0/gtk.css".text = ''
          @import url("file://${cfg.theme.package}/share/themes/${cfg.theme.name}/gtk-4.0/gtk.css")
        '';
      };
    };

    programs.dconf = {
      enable = true;
      profiles.user.databases = [
        {
          lockAll = true;
          settings = {
            "org/gnome/desktop/interface" = {
              gtk-theme = cfg.theme.name;
              icon-theme = cfg.iconTheme.name;
              color-scheme = "prefer-dark";
            };
          };
        }
      ];
    };
  };
}
