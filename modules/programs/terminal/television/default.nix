{
  inputs,
  lib,
  pkgs,
  ...
}:
let
  inherit (lib) removeSuffix genAttrs';
  inherit (builtins) readDir attrNames;

  toml = pkgs.formats.toml { };
  cableFiles = attrNames (readDir ./cable);
in
{
  hj = {
    packages = [ inputs.self.packages.${pkgs.stdenv.hostPlatform.system}.television ];

    xdg.config.files = genAttrs' cableFiles (
      cable:
      let
        fileName = "${removeSuffix ".nix" cable}.toml";
      in
      {
        name = "television/cable/${fileName}";
        value = {
          generator = toml.generate fileName;
          value = import ./cable/${cable};
        };
      }
    );
  };
}
