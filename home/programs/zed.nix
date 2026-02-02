{
  lib,
  pkgs,
  ...
}:
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

  home.packages = [ pkgs.nixfmt ]; # for an unknown reason nixd fails when the formatter is passed as a path instead of being available in the environment
}
