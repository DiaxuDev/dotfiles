{ lib, pkgs, ... }:
{
  hj = {
    packages = with pkgs.qt6Packages; [
      qt6ct
      qtstyleplugin-kvantum
    ];

    environment.sessionVariables = {
      QT_QPA_PLATFORMTHEME = "qt6ct";
    };

    xdg.config.files = {
      "qt6ct/qt6ct.conf" = {
        generator = lib.generators.toINI { };
        value = {
          Appearance = {
            icon_theme = "Papirus-Dark";
            standard_dialogs = "xdgdesktopportal";
            style = "kvantum";
            custom_palette = true;
          };
        };
      };

      "Kvantum/Gruvbox-Dark-Brown".source = "${pkgs.gruvbox-kvantum}/share/Kvantum/Gruvbox-Dark-Brown";
      "Kvantum/kvantum.kvconfig".text = "[General]\ntheme=Gruvbox-Dark-Brown";
    };
  };
}
