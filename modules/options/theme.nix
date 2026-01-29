{ lib, ... }:
{
  options.modules.colors = lib.options.mkOption {
    description = "An attribute set containing colors";
    type = with lib.types; attrsOf str;
  };
}
