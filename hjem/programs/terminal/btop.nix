{ lib, pkgs, ... }:
{
  hj = {
    packages = [ pkgs.btop-cuda ];

    xdg.config.files."btop/btop.conf" = {
      generator = lib.generators.toKeyValue {
        mkKeyValue = lib.generators.mkKeyValueDefault { } "=";
      };
      value = {
        color_theme = "gruvbox_material_dark";
      };
    };
  };
}
