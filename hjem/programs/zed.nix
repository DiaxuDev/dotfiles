{ lib, pkgs, ... }:
{
  hj = {
    # for an unknown reason nixd refuses to accept my custom formatter command so nixfmt is here as a workaround
    packages = with pkgs; [
      zed-editor
      nixfmt
    ];

    xdg.config.files."zed/settings.json" = {
      generator = lib.generators.toJSON { };
      value = {
        theme = "Gruvbox Dark";
        icon_theme = "Material Icon Theme";
        auto_install_extensions = lib.genAttrs [ "emmet" "html" "material-icon-theme" "nix" ] (_: true);
        disable_ai = true;
        project_panel.dock = "left";
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
          nixd = {
            binary.path = lib.getExe pkgs.nixd;
          };
          package-version-server.binary.path = lib.getExe pkgs.package-version-server;
        };
      };
    };
  };
}
