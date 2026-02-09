{ lib, config, ... }:
{
  options.modules.colors = lib.options.mkOption {
    description = "An attribute set containing colors";
    type = with lib.types; attrsOf str;
  };

  config = {
    home.file."preview.html".text = lib.concatStringsSep "\n" (
      lib.mapAttrsToList (
        name: value: "<div style='background: ${value};'>${name}</div>"
      ) config.modules.colors
    );
  };
}
