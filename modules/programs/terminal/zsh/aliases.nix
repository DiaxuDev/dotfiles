{ lib, ... }:
let
  inherit (builtins) concatStringsSep;
  inherit (lib) strings lists;
in
{
  cfg.zsh.rc = lib.mkOrder 1100 (
    ''
      function mkcd() {
        mkdir -p $@ && cd ''${@:$#}
      }

    ''
    + lib.concatLines (
      builtins.genList (
        x:
        "alias ${strings.replicate (x + 2) "."}='cd ${concatStringsSep "/" (lists.replicate (x + 1) "..")}'"
      ) 2
    )
  );
}
