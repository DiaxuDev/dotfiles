{ lib, pkgs, ... }:
{
  programs.zed-editor = {
    enable = true;
    userSettings = {
      languages = {
        Nix = {
          language_servers = [
            "nixd"
            "!nil"
          ];
        };
      };
      lsp = {
        nixd.binary.path = lib.getExe pkgs.nixd;
      };
    };
  };
}
