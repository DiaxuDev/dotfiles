{ lib, pkgs, ... }:
let
  themePkg = pkgs.gruvbox-gtk-theme;
  themeName = "Gruvbox-Dark";
  iconThemeName = "Papirus-Dark";

  Settings = {
    gtk-theme-name = themeName;
    gtk-icon-theme-name = iconThemeName;
    gtk-application-prefer-dark-theme = true;
    gtk-cursor-theme-name = "Banana";
    gtk-cursor-theme-size = 40;
  };
in
{
  hj = {
    packages = [
      pkgs.papirus-icon-theme
      themePkg
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
        @import url("file://${themePkg}/share/themes/${themeName}/gtk-4.0/gtk.css")
      '';
    };
  };

  programs.dconf.profiles.user.databases = [
    {
      lockAll = true;
      settings = {
        "org/gnome/desktop/interface" = {
          gtk-theme = themeName;
          icon-theme = iconThemeName;
          color-scheme = "prefer-dark";
        };
      };
    }
  ];

}
