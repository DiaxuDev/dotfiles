{
  pkgs,
  config,
  ...
}:
let
  qtct = {
    Appearance = {
      custom_palette = false;
      icon_theme = config.gtk.iconTheme.name;
      standard_dialogs = "xdgdesktopportal";
      style = "kvantum";
    };
  };
in
{
  imports = [
    ../modules/options/theme.nix
  ];

  gtk = {
    enable = true;

    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.papirus-icon-theme;
    };

    theme = {
      name = "adw-gtk3-dark";
      package = pkgs.adw-gtk3;
    };
  };

  qt = {
    enable = true;
    platformTheme.name = "qtct";
    style.name = "kvantum";

    qt5ctSettings = qtct;
    qt6ctSettings = qtct;
  };

  xdg.configFile = {
    "Kvantum/Gruvbox-Dark-Brown".source = "${pkgs.gruvbox-kvantum}/share/Kvantum/Gruvbox-Dark-Brown";
    "Kvantum/kvantum.kvconfig".text = "[General]\ntheme=Gruvbox-Dark-Brown";
  };

  dconf.settings."org/gnome/desktop/interface".color-scheme = "prefer-dark"; # this is still respected by some apps (e. g. firefox)

  home.pointerCursor = {
    package = pkgs.banana-cursor;
    name = "Banana";
    size = 40;
    gtk.enable = true;
  };

  modules.colors = {
    base00 = "#292828";
    base01 = "#32302f";
    base02 = "#504945";
    base03 = "#665c54";
    base04 = "#bdae93";
    base05 = "#ddc7a1";
    base06 = "#ebdbb2";
    base07 = "#fbf1c7";
    base08 = "#ea6962";
    base09 = "#e78a4e";
    base0A = "#d8a657";
    base0B = "#a9b665";
    base0C = "#89b482";
    base0D = "#7daea3";
    base0E = "#d3869b";
    base0F = "#bd6f3e";
  };
}
