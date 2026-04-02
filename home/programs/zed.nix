{
  lib,
  pkgs,
  ...
}:
{
  programs.zed-editor = {
    enable = true;
    userSettings = {
      # there is literally a char made specifically for the purpose of indenting content, why do people insist on using spacecs
      hard_tabs = true;
      load_direnv = "shell_hook";
      diagnostics.inline.enabled = true;

      languages = {
        Nix = {
          language_servers = [
            "nixd"
            "!nil"
          ];
        };
        Rust = {
          hard_tabs = false;
        };
      };
      lsp = {
        nixd.binary.path = lib.getExe pkgs.nixd;
        package-version-server.binary.path = lib.getExe pkgs.package-version-server;
      };
    };
  };

  home.packages = [ pkgs.nixfmt ]; # for an unknown reason nixd fails when the formatter is passed as a path instead of being available in the environment
}
