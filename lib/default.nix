lib:
let
  callLibs = file: import file lib;
in
lib.fix (self: {
  systemd = callLibs ./systemd.nix;

  inherit (self.systemd) mkGraphicalService;
})
