{ lib, pkgs, ... }:
let
  inherit (builtins) concatStringsSep;
  inherit (lib) imap0 optionalString concatMapStringsSep;
in
{
  programs.xfconf.enable = true;
  services.tumbler.enable = true;
  environment.systemPackages = with pkgs; [ file-roller ];

  programs.thunar = {
    enable = true;
    plugins = with pkgs; [
      thunar-archive-plugin
    ];
  };

  hj.xdg.config.files."Thunar/uca.xml".text =
    let
      mkFileType = type: "  <${type}${optionalString (type != "directories") "-files"} />";
      mkAction =
        id: action:
        ''
          <action>
            <icon>${action.icon}</icon>
            <name>${action.name}</name>
            <submenu>${action.submenu or ""}</submenu>
            <unique-id>${toString id}</unique-id>
            <command>${action.command}</command>
            <description>${action.description or ""}</description>
            <range>${action.range or ""}</range>
            <patterns>${action.patterns or "*"}</patterns>
        ''
        + optionalString (action.notify or true) "  <startup-notify />\n"
        + concatMapStringsSep "\n" mkFileType action.fileTypes
        + ''

          </action>
        '';

      actions = [
        {
          name = "Open terminal here";
          icon = "utilities-terminal";
          command = "kitty --directory %f";
          fileTypes = [ "directories" ];
        }
      ];
    in
    ''
      <?xml version="1.0" encoding="UTF-8"?>
      <actions>
      ${concatStringsSep "\n" (imap0 mkAction actions)}
      </actions>
    '';
}
