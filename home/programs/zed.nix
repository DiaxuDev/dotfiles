{ lib, pkgs, ... }:
{
  programs.zed-editor = {
    enable = true;
    userSettings.lsp = {
      nixd.binary.path = lib.getExe pkgs.nixd;
      nil.binary.path = lib.getExe pkgs.nil;
    };
  };
}
