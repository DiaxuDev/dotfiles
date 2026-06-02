{
  config,
  lib,
  ...
}:
let
  inherit (lib) mkOption types;
in
{
  imports = [
    ./options.nix
    ./plugins.nix
  ];

  options.cfg.zsh = {
    rc = mkOption {
      type = types.lines;
      description = "Content to add to .zshrc";
    };
  };

  config = {
    hj = {
      files.".zshenv".text = ''
        if [ -z "$__HJEM_ENV_SOURCED" ]; then
          source ${config.hj.environment.loadEnv}
          export __HJEM_ENV_SOURCED=1
        fi
        export ZDOTDIR=${config.hj.xdg.config.directory}/zsh
      '';

      xdg.config.files."zsh/.zshrc".text = config.cfg.zsh.rc;
    };
  };
}
