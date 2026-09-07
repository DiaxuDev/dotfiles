{
  config,
  lib,
  pkgs,
  ...
}:
{
  hj = {
    packages = [ pkgs.kitty ];

    xdg.config.files."kitty/kitty.conf" = {
      generator = lib.generators.toKeyValue {
        mkKeyValue = lib.generators.mkKeyValueDefault { } " ";
      };

      value = {
        font_family = "JetBrainsMono NF";
        font_size = 10;
        shell_integration = "enabled";
        tab_bar_style = "slant";
      }
      // (with config.cfg.meta.colors.hex; {
        foreground = fg1;
        background = bg0;
        selection_background = fg1;
        selection_foreground = bg0;
        url_color = fg0;
        cursor = fg1;
        inactive_border_color = bg3;
        active_border_color = primary;
        active_tab_background = bg0;
        active_tab_foreground = primary;
        inactive_tab_background = bg1;
        inactive_tab_foreground = fg1;
        tab_bar_background = bg1;

        color0 = black;
        color1 = red;
        color2 = green;
        color3 = yellow;
        color4 = blue;
        color5 = magenta;
        color6 = cyan;
        color7 = white;
        color8 = bright-black;
        color9 = bright-red;
        color10 = bright-green;
        color11 = bright-yellow;
        color12 = bright-blue;
        color13 = bright-magenta;
        color14 = bright-cyan;
        color15 = bright-white;
      });
    };
  };
}
